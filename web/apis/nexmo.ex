defmodule Bankbot.Nexmo do
  require Logger
  
  def send(to, msg) do
    nexmo_key    = Application.get_env(:bankbot, Bankbot.Endpoint) |> Dict.get(:nexmo_key)
    nexmo_secret = Application.get_env(:bankbot, Bankbot.Endpoint) |> Dict.get(:nexmo_secret)
    phone_number = "447520635777"

    query = [
      "api_key=#{nexmo_key}",
      "api_secret=#{nexmo_secret}",
      "to=#{to}",
      "from=#{phone_number}",
      "text=#{msg}"
    ]

    nexmo_url = "https://rest.nexmo.com/sms/json?" <> Enum.join(query, "&")

    HTTPoison.start
    HTTPoison.get(nexmo_url)
  end
end