# encoding: UTF-8
class Offer
  include DataMapper::Resource

  property :id,         			Serial, :required => true
  property :status,      	    Integer
  property :driver,           Integer
  property :datetime,      		String
  property :origin,           String
  property :destination,      String
  property :originAddress,    String
  property :destinationAddress, String
  property :carInfo,          String
end
