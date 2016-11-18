post '/poliRide/createFuel' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"name" and body.has_key?"emissionValue")
    unless (Fuel.first(:name => body["name"]).nil?)
      status 403
      response["error"] = 14
    else
      fuel = Fuel.create(
        name: body["name"],
        emissionValue: body["emissionValue"]
      )
      status 201
      response = fuel
    end
  else
    status 422
    format_response(response, request.accept)
  end

  format_response(response, request.accept)
end

get '/poliRide/fuel/:id' do
  response = Fuel.first(:id => params[:id])
  if (response.nil?)
    status 404
  else
    status 200
  end
  format_response(response, request.accept)
end

get '/poliRide/fuels' do
  format_response(Fuel.all(), request.accept)
end
