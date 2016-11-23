post '/poliRide/query' do
  responseOffers = Array.new
  body = JSON.parse request.body.read

  if (body.has_key?"origin" and body.has_key?"destination" and body.has_key?"maxDistance" and body.has_key?"datetime")
    ori = location_destring(body["origin"])
    latO = ori[0]
    lngO = ori[1]

    dst = location_destring(body["destination"])
    latD = dst[0]
    lngD = dst[1]

    minTime = (Time.parse(body["datetime"]) - 1800).to_i
    maxTime = (Time.parse(body["datetime"]) + 1800).to_i

    offers = Offer.all(:status => 1)
    offers.each do |of|
      dOri = location_destring(of.origin)
      latDO = dOri[0]
      lngDO = dOri[1]

      dDst = location_destring(of.destination)
      latDD = dDst[0]
      lngDD = dDst[1]

      originDistance = location_distance(latO, lngO, latDO, lngDO)
      destinationDistance = location_distance(latD, lngD, latDD, lngDD)

      offerDatetime = Time.parse(of.datetime).to_i

      if (originDistance<=body["maxDistance"] and destinationDistance<=body["maxDistance"])
        if (offerDatetime.between?(minTime, maxTime))
          responseOffers << of
        end
      end
    end
  else
    status 422
  end

  format_response(responseOffers, request.accept)
end
