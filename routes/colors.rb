post '/poliRide/createColor' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"bgr" and body.has_key?"name")
    unless (Color.first(name: body["name"]).nil?)
      status 403
      response["error"] = 7
    else
      color = Color.create(
        bgr: body["bgr"],
        name: body["name"]
      )
      status 201
      response = color
    end
  else
    status 422
  end
  format_response(response, request.accept)
end

get '/poliRide/color/:id' do
  response = Color.first(id: params[:id])
  if (response.nil?)
    status 404
  else  
    status 200
  end
  format_response(response, request.accept)
end

get '/poliRide/colors' do
  format_response(Color.all(), request.accept)
end

post '/poliRide/findColor' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"name")
    response = Color.first(name: body["name"])
    status 200
  elsif (body.has_key?"bgr")
    response = Color.first(bgr: body["bgr"])
    status 200
  else
    status = 404
  end

  format_response(response, request.accept)
end
