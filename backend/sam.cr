require "./config/initializers/database"
require "sam"
require "./src/models/*"
require "./db/migrations/*"

# Here you can define your tasks
load_dependencies "jennifer"

Sam.help
