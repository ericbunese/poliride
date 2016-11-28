def validate_pass(pass)
  return (pass.length>=4)
end

#Cyphers the pass
def cypher_pass(pass)
  return $phpass.hash(pass)
end

#Tests password for cyphered password.
def test_pass(encr, pass)
  return ($phpass.check(pass, encr))
end

def generate_confirmationCode(user)
  cc = "100kstrong"
  #@Change this for non-dummy cc.
  return cc
end

#Validates GRR
def validate_grr(grr)
  return not(/GRR\d{8}/.match(grr).nil?)
end

#Validates @ufpr.br e-mails
def validate_email(email)
  return not(/(\w|\.|\_)*@ufpr\.br/.match(email).nil?)
end

#Validates brazilian license plates
def validate_licensePlate(licensePlate)
  return not(/\w{3}\d{4}/.match(licensePlate).nil?)
end

#Tests for an user's existance
def user_exists(userid)
  user = User.first(id: userid)
  return (not user.nil?)
end

#Tests for an offer's existance
def offer_exists(offerid)
  offer = Offer.first(id: offerid)
  return (not offer.nil?)
end

#Tests for a fuel's existance
def fuel_exists(fuelid)
  fuel = Fuel.first(id: fuelid)
  return (not fuel.nil?)
end

#Gets important info about a user
def get_user_info(user)
  u = Hash.new
  u["id"] = user["id"]
  u["firstName"] = user["firstName"]
  u["lastName"] = user["lastName"]
  u["email"] = user["email"]
  u["grr"] = user["grr"]
  u["phoneNumber"] = user["phoneNumber"]
  u["gender"] = user["gender"]
  u["accountConfirmed"] = user["accountConfirmed"]
  u["level"] = calculate_level(user["experiencePoints"])
  u["xp"] = user["experiencePoints"]
  u["money"] = user["currencyPoints"]
  return u
end

#turns lat and long into string
def location_string(lat, lng)
  return lat.to_s + ";" + lng.to_s
end

#turns location string into lat and lng
def location_destring(string)
  a = string.split(";")
  c = Array.new
  a.each {|b| c << b.to_f}
  return c
end

#Converts degrees to radians
def degrees_to_radians(degrees)
  return degrees * Math::PI / 180
end

#Calculates the distance between two given points
def location_distance(lat1, lng1, lat2, lng2)
  lat1 = degrees_to_radians(lat1)
  lat2 = degrees_to_radians(lat2)
  lng1 = degrees_to_radians(lng1)
  lng2 = degrees_to_radians(lng2)
  dlon = lng2 - lng1
  dlat = lat2 - lat1
  a = (Math.sin(dlat/2))**2 + Math.cos(lat1) * Math.cos(lat2) * (Math.sin(dlon/2))**2
  c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a) )
  d = 6373 * c
  return d
end

#Calculate a user's level by exp.
def calculate_level(experiencePoints)
  return (experiencePoints / 1000).floor+1
end

def join_ride_offer(ride)
  ret = Hash.new
  ret["id"] = ride.id
  ret["driver"] = ride.driver
  ret["rider"] = ride.rider
  ret["status"] = ride.status
  offer = Offer.first(id: ride.offer)
  unless(offer.nil?)
    ret["offer"] = offer
  else
    ret["offer"] = ""
  end
  return ret
end

def join_offer_rides(offer)
  ret = Hash.new
  ret["id"] = offer.id
  ret["status"] = offer.status
  ret["driver"] = offer.driver
  ret["datetime"] = offer.datetime
  ret["origin"] = offer.origin
  ret["destination"] = offer.destination
  ret["originAddress"] = offer.originAddress
  ret["destinationAddress"] = offer.destinationAddress
  ret["carInfo"] = offer.carInfo
  ret["rides"] = Array.new

  ret["rides"] = Ride.all(offer: offer.id)
  return ret
end
