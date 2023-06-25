require "http/client"

def locationsRickMortyApi(data : Array)
  locationsData = data.join(",")
  response = HTTP::Client.get("https://rickandmortyapi.com/api/location/#{locationsData}")

  Array(JSON::Any).from_json(response.body)
end