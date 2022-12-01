# UsersApi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
    Remember that If you are looking for something similar to npm install --save, then this does not exist in Elixir. 
    You install things by adding them to deps: in the mix.exs file in the root of your project then running mix deps.get.
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



DEV NOTES
=============

### This project was created using this command
`mix phx.new users_api --no-html --no-webpack --binary-id`

*NOTE:* using the `--no-webpack` flag didn't work for me using mix version 1.14.1 when executed with this flag it didn't work

### Generating a context of modules for Admin section

`mix phx.gen.context Admin User users   name:string email:string:unique role:string address:string`

### run ecto.migrate immediately after this

`mix ecto.migrate`

### Generate controller and view to handle json requests 
We pass `--no-context` and `--no-schema` since we already created those on the last command.

`mix phx.gen.json Admin User users name:string email:string:unique role:string address:string --no-context --no-schema`

### Adding new fields to a model in ecto 
If you use ecto, just generate a migration using mix ecto.gen.migration todos_add_author_column and add a column in the newly generated `priv/repo/migrations/<timestamp>_todos_add_author_column.exs` file like this :

```
def change do
  alter table("todos") do
    add :author, :text
  end
end
```

*SOurce:* https://stackoverflow.com/questions/48494655/how-to-add-field-in-existing-table-phoenix

#### How to generate a secret using phx.gen.secret 
this will use Joken to generate the secret

`mix phx.gen.secret`

#### Run phoenix project from iex interactive shell 
and Debug functions to get info about the app or run functions manually.
ON the root of your phoenix project run the following:

`iex -S mix`

This will load the project on iex

`C:\Users\juan.figueroa\Documents\ELIXIR\mix-projects\users_api>iex -S mix`

```
warning: the :gettext compiler is no longer required in your mix.exs.

Please find the following line in your mix.exs and remove the :gettext entry:

    compilers: [..., :gettext, ...] ++ Mix.compilers(),

  (gettext 0.20.0) lib/mix/tasks/compile.gettext.ex:5: Mix.Tasks.Compile.Gettext.run/1
  (mix 1.14.1) lib/mix/task.ex:421: anonymous fn/3 in Mix.Task.run_task/4
  (mix 1.14.1) lib/mix/tasks/compile.all.ex:92: Mix.Tasks.Compile.All.run_compiler/2
  (mix 1.14.1) lib/mix/tasks/compile.all.ex:72: Mix.Tasks.Compile.All.compile/4
  (mix 1.14.1) lib/mix/tasks/compile.all.ex:59: Mix.Tasks.Compile.All.with_logger_app/2
  (mix 1.14.1) lib/mix/tasks/compile.all.ex:33: Mix.Tasks.Compile.All.run/1

Interactive Elixir (1.14.1) - press Ctrl+C to exit (type h() ENTER for help)
```

After this you can run for example this command to see if a route is correctly applied to the project 
(you can also run on the shell `mix phx.routes` for a raw view)

```
iex(16)> UsersApiWeb.Router.Helpers.user_path(UsersApiWeb.Endpoint, :create) |> IO.inspect
"/api/users"
"/api/users"
```

*SOURCE*: https://hexdocs.pm/phoenix/routing.html#path-helpers




### COMMON ISSUES
#### Not defining schema of the table when creating the context for a module
if when creating a new model and controller and running the route tells 
you that migrations needs to be done and then you do ecto.migrate and 
it throws a message that a create_users is duplicated in priv/repos/migrations
run this command then try to run ecto.migrate or ecto.create again

`mix clean`

*NOTE:* I had to use this command because I ran the mix phx.gen.context Admin User users without ## the table definition so on reality I didn't create the table just the files for the context at the context for Admin and User but no table definition.


