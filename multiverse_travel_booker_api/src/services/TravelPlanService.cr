require "../helpers/serializers/TravelParams"
require "./locationsRickMortyApi"


class TravelPlanService
  
  getter travelPlanRepository : ITravelPlanRepository

  def initialize(@travelPlanRepository)
  end

  def getAll
    self.travelPlanRepository.list
  end

  def findById (id : Int32)
    self.travelPlanRepository.findById(id)
  end

  def createPlan (data : String)
    travelParams = TravelParams.from_json(data)

    self.travelPlanRepository.create(travelParams.travel_stops)
  end

  def updatePlan(id : Int32, data : String)
    travelParams = TravelParams.from_json(data)

    self.travelPlanRepository.update(id, travelParams.travel_stops)

    self.travelPlanRepository.findById(id)
  end

  def deletePlan (id : Int32)
    self.travelPlanRepository.delete(id)
  end

  def appendStops (id : Int32, data : String)
    travelParams = TravelParams.from_json(data)

    travelPlan = self.travelPlanRepository.findById(id)

    travelPlanStops = travelPlan.not_nil!.travel_stops
    travelPlanStops.concat(travelParams.travel_stops)

    self.travelPlanRepository.update(id, travelPlanStops)

    travelPlan.not_nil!.reload
  end

  def expandTravelList (travelList)
    travelList.map do |travelItem|
      {
        "id" => travelItem.id,
        "travel_stops" => self._expandTravelStops(travelItem.travel_stops).as(Array(Hash(String, JSON::Any)))
      }
    end
  end

  def expandTravelPlan (id, travelPlan)
    {
      "id" =>  travelPlan.not_nil!.id,
      "travel_stops" => self._expandTravelStops( travelPlan.not_nil!.travel_stops)
    }
  end

  def _expandTravelStops(travel_stops : Array(Int32))
    locations = locationsRickMortyApi(travel_stops)
  
    travel_stops.map do |id|
      location = locations.find{ |location| location["id"] == id}.as(JSON::Any)
      
      {
        "id" => location["id"],
        "name" => location["name"],
        "type" => location["type"],
        "dimension" => location["dimension"]
      }.as(Hash(String, JSON::Any))
    end
  end
end