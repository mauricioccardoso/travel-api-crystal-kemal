require "../helpers/response"

class  TravelPlanController

  getter travelPlanService : TravelPlanService

  def initialize(@travelPlanService)
  end

  def listAll (params, response)
    optimize = params.query["optimize"]? == "true"
    expand = params.query["expand"]? == "true"

    travelList = self.travelPlanService.getAll

    if !travelList.empty? && expand
      travelList = self.travelPlanService.expandTravelList(travelList)
    end

    response(response, travelList)
  end

  def listOne (params, response)
    optimize = params.query["optimize"]? == "true"
    expand = params.query["expand"]? == "true"
    id = params.url["id"].to_i

    travelPlan = self.travelPlanService.findById(id)

    if !travelPlan.nil? && expand
      travelPlan = self.travelPlanService.expandTravelPlan(id, travelPlan)
    end

    response(response, travelPlan)
  end

  def create (params, response)
    travelPlan = self.travelPlanService.createPlan(params.json.to_json)

    response(response, travelPlan, 201)
  end

  def update (params, response)
    id = params.url["id"].to_i
    
    travelPlan = self.travelPlanService.updatePlan(id, params.json.to_json)

    response(response, travelPlan)
  end

  def delete (params, response)
    id = params.url["id"].to_i

    self.travelPlanService.deletePlan(id)

    response(response, nil, 204)
  end

  def append (params, response)
    id = params.url["id"].to_i

    travelPlan = self.travelPlanService.appendStops(id, params.json.to_json)

    response(response, travelPlan)
  end
end