# encoding: UTF-8
class Course
  include DataMapper::Resource

  property :id,         			Serial, :required => true
  property :name,             String
end
