post '/poliRide/createCar' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"licensePlate" and body.has_key?"maker" and body.has_key?"model" and body.has_key?"ownerId" and body.has_key?"year" and body.has_key?"color")
    unless (Car.first(:licensePlate => body["licensePlate"]).nil?)
      p Car.first(:licensePlate => body["licensePlate"])
      status 403
      response["error"] = 4
    else
      if (validate_licensePlate(body["licensePlate"]))
        if (user_exists(body["ownerId"]))
          car = Car.create(
            licensePlate: body["licensePlate"],
            maker: body["maker"],
            carModel: body["model"],
            year: body["year"],
            color: body["color"],
            owner: body["ownerId"]
          )
          status 201
          response = car
        else
          status 404
          response["error"] = 6
        end
      else
        status 403
        response["error"] = 5
      end
    end
  else
    status 422
    format_response(response, request.accept)
  end

  format_response(response, request.accept)
end

get '/poliRide/car/:id' do
  response = Car.first(:id => params[:id])
  if (response.nil?)
    status 404
  else
    status 200
  end
  format_response(response, request.accept)
end

get '/poliRide/cars' do
  format_response(Car.all(), request.accept)
end

get '/poliRide/userCars/:id' do
  response = Car.all(:owner => params[:id])
  status 200
  format_response(response, request.accept)
end
