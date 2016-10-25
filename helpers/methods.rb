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

#Tests for a user's existance
def user_exists(userid)
  user = User.first(id: userid)
  return (not user.nil?)
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
  return u
end
