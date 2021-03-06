defmodule Bankbot.IncomingController do
  use Bankbot.Web, :controller

  def index(conn, %{"msisdn" => number, "text" => message}) do
    
    teller_message = case Wit.request(message) do
      {:message, message, ctx}    -> message             
      {:action, "pay", ctx}       -> "Okay, I'm paying #{ctx.contact} £#{ctx.amount_of_money} now"
      {:action, "balance", ctx}   -> "Your balance is £4,506"
      {:action, "statement", ctx} -> "Your last transactions were for Nando's, Boots, Wetherspoons and Betfair."
    end
        
    Nexmo.send(number, teller_message)
    
    text(conn, "Done") 
  end
end
