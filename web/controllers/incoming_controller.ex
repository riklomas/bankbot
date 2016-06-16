defmodule Bankbot.IncomingController do
  use Bankbot.Web, :controller

  def create(conn, params) do
    Logger.info params
    
    text(conn, "Done") 
  end
end
