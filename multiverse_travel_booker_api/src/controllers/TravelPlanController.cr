require "../helpers/response"
require "../helpers/responseError"
require "../models/TravelPlan"

class  TravelPlanController

  property travelPlanService : TravelPlanService

  def initialize(@travelPlanService)
  end

  def getAll (params, response)
    begin
      optimize = params.query["optimize"]? == "true"
      expand = params.query["expand"]? == "true"
  
      travelList = travelPlanService.getAll.as(Array(TravelPlan))
  
      if !travelList.empty? && expand && !optimize
        travelList = travelList.map do |travelItem|
          travelPlanService.expandTravelPlan(travelItem)
        end

      elsif !travelList.empty? && optimize
        travelList = travelList.map do |travelItem|
          travelPlanService.optimize(travelItem, expand)
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

      travelPlan = travelPlanService.findById(id)

      if !travelPlan.nil? && expand && !optimize
        travelPlan = travelPlanService.expandTravelPlan(travelPlan)

      elsif !travelPlan.nil? && optimize
        travelPlan = travelPlanService.optimize(travelPlan, expand)
      end

      response(response, travelPlan)

    rescue exception
      responseError(response, exception)
    end
  end

  def create (params, response)
    begin
      travelPlan = travelPlanService.createPlan(params.json.to_json)
  
      response(response, travelPlan, 201)
      
    rescue exception
      responseError(response, exception)
    end
  end

  def update (params, response)
    begin
      id = params.url["id"].to_i
    
      travelPlan = travelPlanService.updatePlan(id, params.json.to_json)

      response(response, travelPlan)

    rescue exception
      responseError(response, exception)
    end
  end

  def delete (params, response)
    begin
      id = params.url["id"].to_i
  
      travelPlanService.deletePlan(id)
  
      response(response, nil, 204)

    rescue exception
      responseError(response, exception)
    end
  end

  def append (params, response)
    begin
      id = params.url["id"].to_i
  
      travelPlan = travelPlanService.appendStops(id, params.json.to_json)
  
      response(response, travelPlan)
      
    rescue exception
      responseError(response, exception)
    end
  end
end