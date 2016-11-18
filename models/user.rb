# encoding: UTF-8
class User
  include DataMapper::Resource

  property :id,         			Serial, :required => true
  property :firstName,      	Text
  property :lastName,         Text
  property :email,      			Text
  property :password,         Text
  property :grr,              Text
  property :gender,           String
  property :phoneNumber,      String
  property :confirmationCode, String
  property :accountConfirmed, Integer
  property :experiencePoints, Integer
  property :currencyPoints, Integer
end
