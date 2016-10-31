# encoding: UTF-8
require 'time'
require 'json'
require 'sinatra'
require 'data_mapper'
require 'dm-migrations'
require 'phpass'
require 'active_support'
require 'simple_geolocation'
require 'timeout'

$phpass = Phpass.new

configure :development do
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
end

require './helpers/init'
require './models/init'
require './routes/init'

DataMapper.finalize
