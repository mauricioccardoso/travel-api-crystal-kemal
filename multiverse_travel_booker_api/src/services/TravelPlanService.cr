require "../models/TravelPlan"
require "../helpers/serializers/TravelParams"

class TravelPlanService
  
  def getAll
    TravelPlan.all.order(id: :asc).to_a
  end

  def findById (id : Int32)
    TravelPlan.find(id)
  end

  def createPlan (data : String)
    travelParams = TravelParams.from_json(data)
    TravelPlan.create(travel_stops: travelParams.travel_stops)
  end

  def updatePlan(id : Int32, data : String)
    travelParams = TravelParams.from_json(data)
    TravelPlan.where { _id == id }.update { {:travel_stops => travelParams.travel_stops} }

    self.findById(id)
  end

  def deletePlan (id : Int32)
    TravelPlan.delete(id)
  end

  def appendStops (id : Int32, data : String)
    travelParams = TravelParams.from_json(data)

    travelPlan = self.findById(id)

    travelPlanStops = travelPlan.not_nil!.travel_stops
    travelPlanStops.concat(travelParams.travel_stops)

    TravelPlan.where { _id == id }.update { {:travel_stops => travelPlanStops} }

    travelPlan.not_nil!.reload
  end

  def expandTravelList (travelList)
    travelList.map do |travelItem|
      {
        "id" => travelItem.id,
        "travel_stops" => self.expandTravelStops(travelItem.travel_stops).as(Array(Hash(String, JSON::Any)))
      }
    end
  end

  def expandTravelPlan (id, travelPlan)
    {
      "id" =>  travelPlan.not_nil!.id,
      "travel_stops" => self.expandTravelStops( travelPlan.not_nil!.travel_stops)
    }
  end

  def expandTravelStops(travel_stops : Array(Int32))
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