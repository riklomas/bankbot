defmodule Bankbot.ChatChannel do
  use Bankbot.Web, :channel

  def join("chats:teller", payload, socket) do
    {:ok, socket}
  end

  def handle_in("message", %{ "message" => message }, socket) do
    
    push(socket, "message", %{ user: "me", message: message })
    
    teller_message = case Wit.request(message) do
      {:message, message, ctx}    -> message             
      {:action, "pay", ctx}       -> "Okay, I'm paying #{ctx.contact} £#{ctx.amount_of_money} now"
      {:action, "balance", ctx}   -> "Your balance is £4,506"
      {:action, "statement", ctx} -> "Your last transactions were for Nando's, Boots, Wetherspoons and Betfair."
    end
    
    push(socket, "message", %{ user: "teller", message: teller_message })
    
    {:noreply, socket}
  end
end
