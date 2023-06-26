require "json"
require "./locationsExpandedFormated"

struct TravelStop
  include JSON::Serializable

  getter id : Int32
  getter travel_stops : Array(LocationsExpandedFormated)
end