require "../helpers/response"
require "../helpers/responseError"

class  TravelPlanController

  getter travelPlanService : TravelPlanService

  def initialize(@travelPlanService)
  end

  def getAll (params, response)
    begin
      optimize = params.query["optimize"]? == "true"
      expand = params.query["expand"]? == "true"
  
      travelList = self.travelPlanService.getAll
  
      if !travelList.empty? && expand
        travelList = travelList.map do |travelItem|
          self.travelPlanService.expandTravelPlan(travelItem)
        end
      end
      
      response(response, travelList)

    rescue exception
      responseError(response, exception)
    end
  end

  def getOne (params, response)
    begin
      optimize = params.query["optimize"]? == "true"
      expand = params.query["expand"]? == "true"
      id = params.url["id"].to_i

      travelPlan = self.travelPlanService.findById(id)

      if !travelPlan.nil? && expand
        travelPlan = self.travelPlanService.expandTravelPlan(travelPlan)
      end

      response(response, travelPlan)

    rescue exception
      responseError(response, exception)
    end
  end

  def create (params, response)
    begin
      travelPlan = self.travelPlanService.createPlan(params.json.to_json)
  
      response(response, travelPlan, 201)
      
    rescue exception
      responseError(response, exception)
    end
  end

  def update (params, response)
    begin
      id = params.url["id"].to_i
    
      travelPlan = self.travelPlanService.updatePlan(id, params.json.to_json)

      response(response, travelPlan)

    rescue exception
      responseError(response, exception)
    end
  end

  def delete (params, response)
    begin
      id = params.url["id"].to_i
  
      self.travelPlanService.deletePlan(id)
  
      response(response, nil, 204)

    rescue exception
      responseError(response, exception)
    end
  end

  def append (params, response)
    begin
      id = params.url["id"].to_i
  
      travelPlan = self.travelPlanService.appendStops(id, params.json.to_json)
  
      response(response, travelPlan)
      
    rescue exception
      responseError(response, exception)
    end
  end
end