require "../helpers/serializers/TravelParams"
require "./locationsRickMortyApi"
require "../helpers/serializers/locationsExpandedFormated"

class TravelPlanService
  
  getter travelPlanRepository : ITravelPlanRepository

  def initialize(@travelPlanRepository)
  end

  def getAll
      self.travelPlanRepository.getAll
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

    if travelPlan.nil?
      return nil
    end

    travelPlanStops = travelPlan.travel_stops
    travelPlanStops.concat(travelParams.travel_stops)

    self.travelPlanRepository.update(id, travelPlanStops)

    travelPlan.reload

  end

  def expandTravelPlan (travelPlan)
    locations = locationsRickMortyApi(travelPlan.travel_stops)
    locationsFormated = Array(LocationsExpandedFormated).from_json(locations)

    {
      "id" =>  travelPlan.not_nil!.id,
      "travel_stops" => locationsFormated
    }
  end
end