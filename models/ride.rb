# encoding: UTF-8
class Ride
  include DataMapper::Resource

  property :id,         			Serial, :required => true
  property :offer,      	    Integer
  property :rider,            Integer
  property :status,           Integer
end
