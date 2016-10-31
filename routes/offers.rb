#Create an offer
post '/poliRide/createOffer' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"driver" and body.has_key?"datetime" and body.has_key?"origin" and body.has_key?"destination")
    offer = Offer.create(
      driver: body["driver"],
      datetime: body["datetime"],
      origin: body["origin"],
      destination: body["destination"],
      status: 1
    )
    status 201
    response = offer
  else
    status 422
  end
  format_response(response, request.accept)
end

#Get a specific offer
get '/poliRide/offer/:id' do
  response = Offer.first(id: params[:id])
  if (response.nil?)
    status 404
  else
    status 200
  end
  format_response(response, request.accept)
end

#Get all offers
get '/poliRide/offers' do
  format_response(Offer.all(), request.accept)
end

#Get a driver's offers
get '/poliRide/offers/:id' do
  format_response(Offer.all(driver: params[:id]), request.accept)
end
