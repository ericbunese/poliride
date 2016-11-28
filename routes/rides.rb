#Create a ride
post '/poliRide/createRide' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"rider" and body.has_key?"offer" and body.has_key?"driver")
    if (offer_exists(body["offer"]))
      if (user_exists(body["rider"]) and user_exists(body["driver"]))
        ride = Ride.create(
          rider: body["rider"],
          offer: body["offer"],
          driver: body["driver"],
          status: 1
        )
        status 201
        response = join_ride_offer(ride)
      else
        status 404
        response["error"] = 6
      end
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
  response = join_ride_offer(Ride.first(id: params[:id]))
  if (response.nil?)
    status 404
  else
    status 200
  end
  format_response(response, request.accept)
end

#Get all rides
get '/poliRide/rides' do
  offers = Ride.all()
  array = Array.new
  offers.each do |of|
    array << join_ride_offer(of)
  end
  format_response(array, request.accept)
end

#Get a driver's rides
get '/poliRide/rides/:id' do
  offers = Ride.all(driver: params[:id])
  array = Array.new
  offers.each do |of|
    array << join_ride_offer(of)
  end
  format_response(array, request.accept)
end

#Get a rider's rides
get '/poliRide/rider/:id' do
  offers = Ride.all(rider: params[:id])
  array = Array.new
  offers.each do |of|
    array << join_ride_offer(of)
  end
  format_response(array, request.accept)
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
