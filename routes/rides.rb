#Create a ride
post '/poliRide/createRide' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"rider" and body.has_key?"offer")
    if (offer_exists(body["offer"]))
      ride = Ride.create(
        rider: body["rider"],
        offer: body["offer"],
        status: 1
      )
      status 201
      response = ride
    else
      status 404
      response["error"] = 10
    end
  else
    status 422
  end
  format_response(response, request.accept)
end

#Get a specific ride
get '/poliRide/ride/:id' do
  response = Ride.first(id: params[:id])
  if (response.nil?)
    status 404
  else
    status 200
  end
  format_response(response, request.accept)
end

#Get all rides
get '/poliRide/rides' do
  format_response(Offer.all(), request.accept)
end

#Get a driver's rides
get '/poliRide/rides/:id' do
  format_response(Ride.all(driver: params[:id]), request.accept)
end

#Update ride's status
post '/poliRide/updateRide' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"id" and body.has_key?"status")
    ride = Ride.first(:id => body["id"])

    unless(ride.nil?)
      ride.update(:status => body["status"])
      response = ride
      status 200
    else
      status 404
    end
  else
    status 422
    response["error"] = 11
  end
  format_response(response, request.accept)
end
