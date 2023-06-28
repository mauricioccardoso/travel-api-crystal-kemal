require "../config/config"
require "json"
require "./routes/api"

module Main
  VERSION = "0.1.0"

  p! "Server ON!"
end

Kemal.run