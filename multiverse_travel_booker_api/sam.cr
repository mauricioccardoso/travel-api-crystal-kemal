require "./config/*"
require "sam"
require "./db/migrations/*"

# Here you can define your tasks
load_dependencies "jennifer"

Sam.help
