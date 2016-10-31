post '/poliRide/query' do
  response = Hash.new
  offers = Array.new
  body = JSON.parse request.body.read

  if (body.has_key?"location")
    loc = location_destring(body["location"])
    #@program the master query here
  else
    status 422
  end

  response["offers"] = offers
  format_response(response, request.accept)
end
