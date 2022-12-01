# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :encryption,
  ecto_repos: [Encryption.Repo]

# Configures the endpoint
config :encryption, EncryptionWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: EncryptionWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Encryption.PubSub,
  live_view: [signing_salt: "Is0E6Vyq"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :encryption, Encryption.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason


# "This is the content of the .env file" |> IO.puts
# File.stream!("./.env")
#   |> Stream.map(&String.trim_trailing/1)
#   |> Enum.map(fn line ->
#     line |> IO.puts
#   end)

# run shell command to "source .env" to load the environment variables.
try do                                     # wrap in "try do"
  File.stream!("./.env")                   # in case .env file does not exist.
    |> Stream.map(&String.trim_trailing/1) # remove excess whitespace
    |> Enum.each(fn line -> line           # loop through each line
      |> String.replace("export ", "")     # remove "export" from line
      |> String.split("=", parts: 2)       # split on *first* "=" (equals sign)
      |> Enum.reduce(fn(value, key) ->     # stackoverflow.com/q/33055834/1148249
        System.put_env(key, value)         # set each environment variable
      end)
    end)
rescue
  _ -> IO.puts "no .env file found!"
end

# Set the Encryption Keys as an "Application Variable" accessible in aes.ex
config :encryption, Encryption.AES,
  keys: System.get_env("ENCRYPTION_KEYS") # get the ENCRYPTION_KEYS env variable
    |> String.replace("'", "")  # remove single-quotes around key list in .env
    |> String.split(",")        # split the CSV list of keys
    |> Enum.map(fn key -> :base64.decode(key) end) # decode the key.

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
