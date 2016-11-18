# encoding: UTF-8
class Fuel
  include DataMapper::Resource

  property :id,         			Serial, :required => true
  property :name,             String
  property :emissionValue,    Float
end
