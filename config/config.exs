# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :beamware,
  ecto_repos: [Beamware.Repo]

# Configures the endpoint
config :beamware, BeamwareWeb.Endpoint,
  url: [host: System.get_env("HOST")],
  secret_key_base: "3uRRXQ9FUMc3dd7NFTFWQU2xRXcVFXWpPLHZ4fdG/toP9/jJL92Mtjmq8Fd/ijZe",
  render_errors: [view: BeamwareWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Beamware.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"