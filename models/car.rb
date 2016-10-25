# encoding: UTF-8
class Car
  include DataMapper::Resource

  property :id,         			Serial, :required => true
  property :licensePlate,     String
  property :maker,            String
  property :carModel,         String
  property :owner,            Integer
  property :year,             Integer
  property :color,            String
end
