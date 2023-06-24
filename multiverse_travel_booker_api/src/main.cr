require "../config/config"
require "json"
require "http/client"

module Main
  VERSION = "0.1.0"
end

get "/travel_plans" do |env|
  optimize = env.params.query["optimize"]? == "true"
  expand = env.params.query["expand"]? == "true"
  
  travelList = TravelPlan.all.to_a.as(Array(TravelPlan))

  if !travelList.empty? && expand
    travelList = travelList.map do |travelItem|
      {
        "id" => travelItem.id,
        "travel_stops" => expand_travel_stops(travelItem.travel_stops).as(Array(Hash(String, JSON::Any)))
      }
    end
  end

  env.response.content_type = "application/json"
  env.response.status_code = 200
  travelList.to_json
end

# Create - OK
class TravelParams
  include JSON::Serializable

  property travel_stops : Array(Int32)
end

post "/travel_plans" do |env|
  travelParams = TravelParams.from_json(env.request.body.not_nil!)
  travelPlan = TravelPlan.create(travel_stops: travelParams.travel_stops)

  env.response.content_type = "application/json"
  env.response.status_code = 201

  travelPlan.to_json
end
# Create ↑ 

#### Funções
# Todo - Mover para outro local
def rickMortyLocationsApi(data : Array)
  locationsData = data.join(",")
  response = HTTP::Client.get("https://rickandmortyapi.com/api/location/#{locationsData}")

  Array(JSON::Any).from_json(response.body)
end

def expand_travel_stops(travel_stops : Array(Int32))
  locations = rickMortyLocationsApi(travel_stops)

  travel_stops_expanded =  travel_stops.map do |id|
    location = locations.find{ |location| location["id"] == id}.as(JSON::Any)
    
    {
      "id" => location["id"],
      "name" => location["name"],
      "type" => location["type"],
      "dimension" => location["dimension"]
    }.as(Hash(String, JSON::Any))
  end

  travel_stops_expanded
end

Kemal.run