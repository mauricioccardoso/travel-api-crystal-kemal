require "kemal"
require "json"
require "../config/*"

module MultiverseTravelBookerApi
  VERSION = "0.1.0"

# inicio
  post "/travel_plans" do |env|
    travelStops = Array(Int32).from_json(env.params.json["travel_stops"].to_s)
    travelPlan = TravelPlan.create(travel_stops: travelStops)

    env.response.content_type = "application/json"
    env.response.status_code = 201

    travelPlan.to_json
  end
# fim

end

Kemal.run
