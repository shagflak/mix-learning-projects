
defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

# We can use pattern matching to assign the messenger value to a variable but still being able to use the params Map
# def show(conn, %{"messenger" => messenger} = params) do
  # def show(conn, %{"messenger" => messenger}) do
  #   render(conn, "show.html", messenger: messenger)
  # end
  # def show(conn, %{"messenger" => messenger}) do
  #   render(conn, "show.html", messenger: messenger)
  # end
  def show(conn, %{"messenger" => messenger}) do
    render(conn, "show.html", messenger: messenger)
  end
end
