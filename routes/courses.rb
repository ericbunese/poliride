post '/poliRide/createCourse' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"name")
    unless (Course.first(name: body["name"]).nil?)
      status 403
      response["error"] = 8
    else
      course = Course.create(
        name: body["name"]
      )
      status 201
      response = course
    end
  else
    status 422
  end
  format_response(response, request.accept)
end

get '/poliRide/course/:id' do
  response = Course.first(id: params[:id])

  if (response.nil?)
    status 404
  else
    status 200
  end
  format_response(response, request.accept)
end

get '/poliRide/courses' do
  format_response(Course.all(), request.accept)
end

post '/poliRide/findCourse' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"name")
    response = Course.first(name: body["name"])
    status 200
  else
    status = 404
  end

  format_response(response, request.accept)
end
