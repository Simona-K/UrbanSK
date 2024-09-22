require 'sinatra'

get '/' do
    'Hello world'
end

get '/api/urbanplans' do
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

