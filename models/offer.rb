# encoding: UTF-8
class Offer
  include DataMapper::Resource

  property :id,         			Serial, :required => true
  property :status,      	    Integer
  property :driver,           Integer
  property :datetime,      		Integer
  property :origin,           String
  property :destination,      String
end
