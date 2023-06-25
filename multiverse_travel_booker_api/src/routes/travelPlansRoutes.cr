require "../repositories/TravelPlanRepository"
require "../services/TravelPlanService"
require "../controllers/TravelPlanController"

travelPlanRepository = TravelPlanRepository.new
travelPlanService = TravelPlanService.new (travelPlanRepository)
travelPlanController = TravelPlanController.new (travelPlanService)

get "/travel_plans" do |env|
  travelPlanController.listAll(env.params, env.response)
end

get "/travel_plans/:id" do |env|
  travelPlanController.listOne(env.params, env.response)
end

post "/travel_plans" do |env|
  travelPlanController.create(env.params, env.response)
end

put "/travel_plans/:id" do |env|
  travelPlanController.update(env.params, env.response)
end

delete "/travel_plans/:id" do |env|
  travelPlanController.delete(env.params, env.response)
end

patch "/travel_plans/:id/append" do |env|
  travelPlanController.append(env.params, env.response)
end