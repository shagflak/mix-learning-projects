# Encryption
This project was made following the example tutorial at 
https://github.com/dwyl/phoenix-ecto-encryption-example#why


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

  

# DEV NOTES

## BLOCKERS WHILE DEVELOPING THIS PROJECT

* .env file reading on config/config.exs was marking error that the file couldn't be found
  at the end was an error with the .env file creation I used a command similar to this one

```
echo "export ENCRYPTION_KEYS=LasdE454fGrrtgh,Rfsdth456" > .env
```
Doing this created the file under utf-16 LE encoding for this reason the <File.stream!> function although it was able to actually
find the file when you start trying to do operations like tryong to read the stream line by line
and exposing the chars to an output it will fail since the utf-16 file will raise a bad encoding exception

What helped me to figure out things was this post on the elixir forum about encoding and how you can print
which caracters on a file might be causing issues the truth it's that the solution was to create the file again from VS Code and this time it will create the file under utf-8 encoding this time opening the file and not throing any error
on the binary data when trying to IO.puts the string to debug it.

* Learned that `Application.get_env` returns a keyword list (a list of tuples basically) so that's why you can do something like
  `Application.get_env(args)[:keys]` since it returns a keyword list you can return the value
  like if it was an array.


* *config/test.exs* has his own db config and apparently creates a test db I don't know if temp
   or virtual somehow since pgadmin will not show any encryption_test db this made me loss
   some hours figuring out why running `mix test` failed to connect to the db if I had the correct
   config under `config/dev.exs`

* .env file we used on config/config.exs to load the ENCRYPTION_KEYS key worked fine but for the SECRET_KEY_BASE we need to load 
  it with something equivalent to "source .env" on windows I followed this guide 
  https://bennett4.medium.com/windows-alternative-to-source-env-for-setting-environment-variables-606be2a6d3e1
  this is why the env.sample exists so you can call it using `call env.sample`

```
C:\Users\juan.figueroa\Documents\ELIXIR\mix-projects\encryption>call env.bat

C:\Users\juan.figueroa\Documents\ELIXIR\mix-projects\encryption>
set SECRET_KEY_BASE=D2EhD+8xSCQGyjqgannRkwiZHg2ReHbC09mrTcC2q7ZxDM/NUvTRZTbFPm+ZrQ5Y

C:\Users\juan.figueroa\Documents\ELIXIR\mix-projects\encryption>echo %SECRET_KEY_BASE%
D2EhD+8xSCQGyjqgannRkwiZHg2ReHbC09mrTcC2q7ZxDM/NUvTRZTbFPm+ZrQ5Y
```

Then on IEX
```
iex(2)> System.get_env("SECRET_KEY_BASE")
"D2EhD+8xSCQGyjqgannRkwiZHg2ReHbC09mrTcC2q7ZxDM/NUvTRZTbFPm+ZrQ5Y"
```

Works like a charm.

*NOTE:* Running this on the vscode terminal doesn't work I opened a new cmd window and from there it ran fine.



