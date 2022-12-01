### Start your Phoenix app with: 
`$ mix phx.server`

### You can also run your app inside IEx (Interactive Elixir) as:

`$ iex -S mix phx.server`

### If you want to create a new model with his view and template run 

mix phx.gen.html Persons Person persons name:string description:text

```
C:\Users\juan.figueroa\Documents\ELIXIR\mix-projects\hello> mix phx.gen.html Persons Person persons name:string description:text
* creating lib/hello_web/controllers/person_controller.ex
* creating lib/hello_web/templates/person/edit.html.heex
* creating lib/hello_web/templates/person/form.html.heex
* creating lib/hello_web/templates/person/index.html.heex
* creating lib/hello_web/templates/person/new.html.heex
* creating lib/hello_web/templates/person/show.html.heex
* creating lib/hello_web/views/person_view.ex
* creating test/hello_web/controllers/person_controller_test.exs
* creating lib/hello/persons/person.ex
* creating priv/repo/migrations/20221111181210_create_persons.exs
* creating lib/hello/persons.ex
* injecting lib/hello/persons.ex
* creating test/hello/persons_test.exs
* injecting test/hello/persons_test.exs
* creating test/support/fixtures/persons_fixtures.ex
* injecting test/support/fixtures/persons_fixtures.ex
```

### How to add all the RESTful verbs to the router on a single line

`resources "/persons", PersonController`


### Remember to update your repository by running migrations:

`$ mix ecto.migrate`

After this Just visit `localhost:4000/persons` and have fun!


## This project was created using this command

`mix phx.new users_api --no-html --no-webpack --binary-id`

## Generating a context of modules for Admin section

`mix phx.gen.context Admin User users   name:string email:string:unique role:string address:string`

Run ecto.migrate immediately after this

`mix ecto.migrate`

## Generate controller and view to handle json requests
we pass --no-context and --no-schema since we already created those on the last command
mix phx.gen.json Admin User users name:string email:string:unique role:string address:string --no-context --no-schema

## If when creating a new model and controller and running the route tells you that migrations needs to be done
If when creating a new model and controller and running the route tells you 
that migrations needs to be done and then you do ecto.migrate and 
it throws a message that a create_users is duplicated in priv/repos/migrations
tun this command then try to run ecto.migrate or ecto.create again

`mix clean`

## Running phoenix project from iex interactive shell 
and Debug functions to get info about the app or run functions manually.
ON the root of your phoenix project run the following

`iex -S mix`

This will load the project on iex

```
C:\Users\juan.figueroa\Documents\ELIXIR\mix-projects\users_api>iex -S mix
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
(you can also run on the shell mix phx.routes for a raw view)

```
iex(16)> UsersApiWeb.Router.Helpers.user_path(UsersApiWeb.Endpoint, :create) |> IO.inspect
"/api/users"
"/api/users"
```


## Sources

* https://blog.logrocket.com/build-rest-api-elixir-phoenix/#lifecycle-of-phoenix-requests
* https://hexdocs.pm/phoenix/routing.html#path-helpers