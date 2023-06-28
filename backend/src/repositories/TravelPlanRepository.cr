require "../models/TravelPlan"
require "./interfaces/ITravelPlanRepository"
class TravelPlanRepository < ITravelPlanRepository

  def getAll
    TravelPlan.all.order(id: :asc).to_a
  end

  def findById (id : Int32)
    TravelPlan.find(id)
  end

  def create (data : Array(Int32))
    TravelPlan.create(travel_stops: data)
  end

  def update (id : Int32, data : Array(Int32))
    TravelPlan.where { _id == id }.update { { :travel_stops => data } }
  end
  
  def delete (id : Int32)
    TravelPlan.delete(id)
  end
end