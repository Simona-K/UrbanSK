require 'sinatra'
require_relative 'data/database'

configure do
    @@database = Database.new
end

get '/' do
    'UrbanSK server app'
end

get '/api/createDatabase' do
    @@database.createUrbanPlansTable
    @@database.createTilesetsTable
    'Database created'
end

get '/api/urbanPlans' do
    urbanPlans = @@database.urbanPlans
    return urbanPlans.to_json
end
    

