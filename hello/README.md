# Hello

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix



# Common issues I faced
## When doing the tutorial at https://hexdocs.pm/phoenix/request_lifecycle.html
When trying to add another page at the last part of the tutorial an error message saying that the show.html was not able to be found
regardless of being there was present and event turning of the server and on again didn't help I had to do
mix compile --force then mix phx.server to lift the server again and it worked.

