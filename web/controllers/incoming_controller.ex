defmodule Bankbot.IncomingController do
  use Bankbot.Web, :controller

  def create(conn, params) do
    Logger.info "#{inspect params}"
    IO.puts "#{inspect params}"
    
    text(conn, "Done") 
  end
end
