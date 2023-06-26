require "jennifer"
require "jennifer/adapter/postgres"
require "colorize"

APP_ENV = "development"

Jennifer::Config.configure do |conf|
    if APP_ENV == "development"
        conf.read("config/database.yml", :development)
        conf.logger.level = :none #:debug
    else
        conf.read("config/database.yml", :development)
        conf.logger.level = :error
    end
end

Log.setup "db", :debug, Log::IOBackend.new(formatter: Jennifer::Adapter::DBFormatter)