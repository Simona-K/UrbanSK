require 'sinatra'
require_relative 'data/database'

configure do
    @@database = Database.new
end

get '/' do
    'Hello world'
end

get '/api/urbanplansHardcoded' do
    '
    {
        "urbanPlans":
        [
            {
                "tilesetId": "alexgizh.buu9d5yi",
                "name": "Ilinden",
                "x": 42.01967,
                "y": 21.42793,
                "zoom": 17
            },
            {
                "tilesetId": "alexgizh",
                "name": "Mal Ring",
                "x": 42,
                "y": 21,
                "zoom": 18
            },
            {
                "tilesetId": "alexgizh",
                "name": "Mal Ring",
                "x": 42,
                "y": 21,
                "zoom": 18
            }
        ]
    }
    '
end

get '/api/createUrbanPlans' do
    @@database.createUrbanPlans
    'Urban plans created'
end

get '/api/urbanPlans' do
    urbanPlans = @@database.urbanPlans
    return urbanPlans.to_json
end
    

