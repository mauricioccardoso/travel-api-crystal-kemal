require "./travelPlanExceptionMessageHandler"

def responseError (
  response,
  message : (Exception | String),
  status_code : Int32 = 400
  )

  if message.is_a?(Exception)
    message = travelPlanExceptionMessageHandler(message)
  end
  
  response.content_type = "application/json"
  response.status_code = status_code
  { message: "#{message}"}.to_json
end