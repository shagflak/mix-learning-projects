defmodule UsersApiWeb.UserController do
  use UsersApiWeb, :controller

  alias UsersApi.Admin
  alias UsersApi.Admin.User
  alias UsersApiWeb.JwtToken

  action_fallback UsersApiWeb.FallbackController

  def index(conn, _params) do
    signer = Joken.Signer.create("HS256", "TyEL+xSt7GyX5orOFmG1Y0GoOD2ByPkakhuv2KQiYjQS4Y5KXNsUuiE60QP0WyWx")
    {:ok, token, _claims} = JwtToken.generate_and_sign(%{}, signer)
    IO.puts "\n\n\nThis is the token...#{token}\n\n\n"

    users = Admin.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    # with executes the right part of the code after the "<-" and applies pattern matching to the response returned by
    # "Admin.create_user" function.
    with {:ok, %User{} = user} <- Admin.create_user(user_params) do
      conn
      |> put_status(:created)
      # When this was first created using the phx.gencontext command
      # it was invoking the Routes.user_path(conn, :show, user))
      # two things here
      # 1. You need to define in the router the show action if not when invoking the user_path for :show is not going to work and say that the route is not defined
      # 2. The second will be that regardless the show action on line 31 is expecting a map key value pair of id: user.id if you send user as a whole object without key id it will say that the enumerable you are sending is not suuported after defining the route on the first step.
      |> put_resp_header("location", Routes.user_path(conn, :show, id: user.id))
      |> render("show.json", user: user)
    end
  end

  # if you pass to this action the whole user map it throws the following error
  # protocol Enumerable not implemented for %UsersApi.Admin.User{__meta__: #Ecto.Schema.Metadata<:loaded, "users">, id: "06381854-994b-4c0c-af3a-2dae6fedcc99", address: "Barcelata", email: "marce@mars.com", name: "marcia", role: "USER", inserted_at: ~N[2022-11-12 20:33:36], updated_at: ~N[2022-11-12 20:33:36]} of type UsersApi.Admin.User (a struct)
  # passing again just the id to test
  def show(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    render(conn, "show.json", user: user)
  end

  # This action was defined like ":edit" on the router.ex which needed to be updated in order to map the correct action
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Admin.get_user!(id)

    with {:ok, %User{} = user} <- Admin.update_user(user, user_params) do
      # show.js on this case when using render funciton is a view rendered that exposes the json.
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Admin.get_user!(id)

    with {:ok, %User{}} <- Admin.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
