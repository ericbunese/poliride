post '/poliRide/location' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"adress")
    begin
      t = Timeout::timeout(3) do
        f = SimpleGeolocation::Geocoder.new(body["address"])
        f.geocode!
        if (f.success?)
          response["latitude"] = f.lat
          response["longitude"] = f.lng
          response["location"] = location_string(f.lat, f.lng)
          response["completeness"] = f.completeness
        else
          status 403
          response["error"] = 13
        end
      end
    rescue Timeout::Error => e
      status 404
      response["error"] = 12
    end
  else
    status 422
  end

  format_response(response, request.accept)
end
