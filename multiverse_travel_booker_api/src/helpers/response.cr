def response (
    response,
    data,
    status_code : Int32 = 200,
    content_type : String = "application/json"
  )

  response.headers.delete("Content-Type")
  response.status_code = status_code
  
  if !data.nil?
    response.content_type = content_type
    data.to_json
  end
end