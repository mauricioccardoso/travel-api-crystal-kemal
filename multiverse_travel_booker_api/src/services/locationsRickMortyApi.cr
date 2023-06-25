require "http/client"

def locationsRickMortyApi(data : Array)
  locationsData = data.join(",")
  response = HTTP::Client.get("https://rickandmortyapi.com/api/location/#{locationsData}")

  response.body
end