# encoding: UTF-8
class Color
  include DataMapper::Resource

  property :id,         			Serial, :required => true
  property :name,             String
  property :bgr,              String
end
