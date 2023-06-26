require "../helpers/serializers/TravelParams"
require "./RickMortyAPI"
require "../helpers/serializers/locationsExpandedFormated"
require "../helpers/SortFunctions"

class TravelPlanService

  property rickMortyApi : RickMortyAPI
  property travelPlanRepository : ITravelPlanRepository

  def initialize(@travelPlanRepository, @rickMortyApi)
  end

  def getAll
      travelPlanRepository.getAll
  end

  def findById (id : Int32)
    travelPlanRepository.findById(id)
  end

  def createPlan (data : String)
    travelParams = TravelParams.from_json(data)

    travelPlanRepository.create(travelParams.travel_stops)
  end

  def updatePlan(id : Int32, data : String)
    travelParams = TravelParams.from_json(data)

    travelPlanRepository.update(id, travelParams.travel_stops)

    travelPlanRepository.findById(id)
  end

  def deletePlan (id : Int32)
    travelPlanRepository.delete(id)
  end

  def appendStops (id : Int32, data : String)
    travelParams = TravelParams.from_json(data)

    travelPlan = travelPlanRepository.findById(id)

    if travelPlan.nil?
      return nil
    end

    travelPlanStops = travelPlan.travel_stops
    travelPlanStops.concat(travelParams.travel_stops)

    travelPlanRepository.update(id, travelPlanStops)

    travelPlan.reload
  end

  def expandTravelPlan (travelPlan)
    locations = rickMortyApi.locations(travelPlan.travel_stops)
    locationsFormated = Array(LocationsExpandedFormated).from_json(locations)

    {
      "id" =>  travelPlan.id,
      "travel_stops" => locationsFormated
    }
  end

  def optimize (travelItem, expand)
    locations = rickMortyApi.locationsAndEpisodes(travelItem.travel_stops)

    locationsSort = sortLocations(locations)

    dataMount(travelItem, locationsSort, expand)
  end

  def dataMount (travelItem, locationsSort, expand)
    if expand
      travelStopData = locationsSort.map do |location|
        {
          "id" => location.id.to_i,
          "name" => location.name,
          "type" => location.type,
          "dimension" => location.dimension
        }
      end
    else
      travelStopData = locationsSort.map do |location|
        location.id.to_i
      end
    end
    
    {
      "id" => travelItem.id,
      "travel_stops" => travelStopData
    }
  end
end