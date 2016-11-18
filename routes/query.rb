post '/poliRide/query' do
  responseOffers = Array.new
  body = JSON.parse request.body.read

  if (body.has_key?"location" and body.has_key?"maxDistance" and body.has_key?"datetime")
    loc = location_destring(body["location"])
    lat1 = loc[0]
    lat2 = loc[1]

    minTime = Time.at(body["datetime"] - 30*60) #Half an hour earlier
    maxTime = Time.at(body["datetime"] + 30*60) #Half an hour later

    offers = Offer.all()
    offers.each do |of|
      loc2 = location_destring(of.origin)
      lat2 = loc[0]
      lng2 = loc[1]

      if (location_distance(lat1, lng1, lat2, lng2)<=body["maxDistance"])
        if (of.datetime.between?(minTime, maxTime))
          responseOffers << of
        end
      end
    end

  else
    status 422
  end

  format_response(responseOffers, request.accept)
end
