defmodule Bankbot.Wit do
  require Logger
    
  def make_session_id do
    :crypto.strong_rand_bytes(32) 
    |> Base.url_encode64 
    |> binary_part(0, 32)
  end
  
  def request(q) when byte_size(q) > 0 do
    session_id = make_session_id
    ctx = %{ session_id: session_id, query: q }
    
    "https://api.wit.ai/converse?v=20160330&session_id=#{ctx.session_id}&q=#{URI.encode(ctx.query)}"
    |> HTTPoison.post("{}", http_headers)
    |> parse_response(ctx)
  end
  
  def request(%{ session_id: session_id, query: query } = ctx, _) do
    q = ctx |> Enum.filter(fn {k,v} -> is_bitstring(v) end)
    
    "https://api.wit.ai/converse?v=20160330&session_id=#{session_id}"
    |> HTTPoison.post("", http_headers) 
    |> parse_response(ctx)
  end
  
  def parse_response(response, %{ session_id: session_id } = ctx) do
    case response do
      {:ok, %HTTPoison.Response{body: jsonbody}} ->
        case Poison.Parser.parse!(jsonbody, keys: :atoms) do
          %{ type: "merge", entities: entities } -> 
            ctx = for {k, v} <- entities, into: ctx do
              case length(v) do
                1 -> {k, (v |> List.first |> Map.get(:value))}
                _ -> {k, (v |> Enum.map(fn x -> Map.get(x, :value) end)) |> Enum.sort }
              end
            end
            __MODULE__.request(ctx, "")
          %{ type: "action", action: action, confidence: c } when c > 0.1 -> {:action, action, ctx}
          %{ type: "action", action: action, confidence: c } -> {:noaction, ctx}
          %{ type: "msg", msg: msg }          -> {:message, msg, ctx}
          %{ type: "stop" }                   -> {:stop}
        end
    end
  end

  defp token do
    Application.get_env(:bankbot, Bankbot.Endpoint) |> Dict.get(:wit_key)
  end
  
  defp http_headers do
    %{
      "Authorization" => "Bearer #{token}", 
      "Content-Type" => "application/json", 
      "Accept" => "Accept: application/vnd.wit.20160330+json"
    }
  end  
end