def travelPlanExceptionMessageHandler (message)
  case message.to_s
  when "Invalid Int32: \"a\""
    "The provided ID in the URL is invalid"

  when "unexpected token '<EOF>' at line 1, column 1"
    "The request body is missing"

  when "Missing JSON attribute: travel_stops\n  parsing TravelParams at line 1, column 1"
    "The provided request body is in an incorrect format"
  else 
    "Could not perform the operation"
  end
end