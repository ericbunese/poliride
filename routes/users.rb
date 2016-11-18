# encoding: UTF-8

#Create new user
post '/poliRide/createUser' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"firstName" and body.has_key?"lastName" and body.has_key?"email" and body.has_key?"password" and body.has_key?"grr" and body.has_key?"gender" and body.has_key?"phoneNumber")
    unless (User.first(:email => body["email"]).nil?)
      status 403
      response["error"] = 0
    else
      if (validate_grr(body["grr"]) and validate_email(body["email"]))
        if (validate_pass(body["password"]))
          user = User.create(
            firstName: body["firstName"],
            lastName: body["lastName"],
            email: body["email"],
            password: cypher_pass(body["password"]),
            grr: body["grr"],
            gender: body["gender"],
            phoneNumber: body["phoneNumber"],
            confirmationCode: generate_confirmationCode(body["grr"]),
            accountConfirmed: 0,
            experiencePoints: 0,
            currencyPoints: 0
          )
          status 201
          response = get_user_info(user)
        else
          status 403
          response["error"] = 15
        end
      else
        status 403
        response["error"] = 1
      end
    end
  else
    status 422
  end
  format_response(response, request.accept)
end

#Update user's information
post '/poliRide/updateUser' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"id")
    user = User.first(:id => body["id"])
    unless(user.nil?)
      firstName = body["firstName"] || user.firstName
      lastName = body["lastName"] || user.lastName
      email = body["email"] || user.email
      password = body["password"] || user.password
      grr = body["grr"] || user.grr
      gender = body["gender"] || user.gender
      phoneNumber = body["phoneNumber"] || user.phoneNumber

      user.update(:firstName => firstName, :lastName => lastName, :email => email, :password => cypher_pass(password), :grr => grr, :gender => gender, :phoneNumber => phoneNumber)
      response = get_user_info(user)
      status 200
    else
      status 404
    end
  else
    status 422
    response["error"] = 2
  end
  format_response(response, request.accept)
end

#Verify user's confirmation code
post '/poliRide/verifyUser' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"id" and body.has_key?"code")
    user = User.first(:id => body["id"])
    unless (user.nil?)
      if (user.confirmationCode==body["code"])
        status 200
        response["verified"] = 1
        user.update(:accountConfirmed => 1)
      else
        status 403
        response["error"] = 2
      end
    else
      status 404
    end
  else
    status 422
    response["error"] = 2
  end
  format_response(response, request.accept)
end

#Get user info by id
get '/poliRide/user/:id' do
  response = User.first(:id => params[:id])
  status 200
  format_response(get_user_info(response), request.accept)
end

#Get all users
get '/poliRide/users' do
  users = Array.new
  response = User.all()
  response.each do |u|
    usr = get_user_info(u)
    users << usr
  end
  format_response(users, request.accept)
end

#Verify user's credentials
post '/poliRide/userCredentials' do
  response = Hash.new
  body = JSON.parse request.body.read

  response["success"] = 0

  if (body.has_key?"email" and body.has_key?"password")
    user = User.first(:email => body["email"])
    unless (user.nil?)
      response["user"] = get_user_info(user)
      if (user["accountConfirmed"]) #@==1
        if (test_pass(user["password"], body["password"]))
          status 200
          response["success"] = 1
        else
          status 403
          response["error"] = 2
        end
      else
        status 403
        response["error"] = 9
      end
    else
      status 404
    end
  else
    status 422
  end

  format_response(response, request.accept)
end

#give points to the user
post '/poliRide/prize' do
  response = Hash.new
  body = JSON.parse request.body.read

  if (body.has_key?"id" and body.has_key?"points")
    user = User.first(:id => body["id"])
    unless (user.nil?)
      currencyPoints = user.currencyPoints+body["points"]
      experiencePoints = user.experiencePoints+body["points"]
      user.update(:experiencePoints => experiencePoints, :currencyPoints => currencyPoints)
    else
      status 404
      response["error"] = -1 #@corrigir código para usuário não encontrado
    end
  else
    status 422
  end

  format_response(response, request.accept)
end
