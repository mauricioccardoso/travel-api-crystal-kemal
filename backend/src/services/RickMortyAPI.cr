require "http/client"
require "../helpers/HttpClient"

class RickMortyAPI

  property httpClient : HttpClient
  property graphqlQuery : String

  def initialize(@httpClient)
    @graphqlQuery = 
    <<-GRAPHQL
      query GetLocations($ids: [ID!]!) {
        locationsByIds (ids: $ids) {
          id
          name
          type
          dimension
          residents {
            episode {
              id
            }
          }
        }
      }
    GRAPHQL

  end

  def locations (ids : Array(Int32))
    locationsData = ids.join(",")

    httpClient.get("/api/location/#{locationsData}")
  end

  def locationsAndEpisodes (ids : Array(Int32))
    reqBody = {"query" => graphqlQuery, "variables" => { "ids" => ids }}.to_json

    httpClient.post("/graphql", reqBody)
  end
end