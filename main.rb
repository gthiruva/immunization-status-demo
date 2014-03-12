require 'sinatra'
require "sinatra/json"

$statuses = ['current', 'out-of-date']
$severeties = ['normal', 'low', 'medium', 'high', 'emergency']

get '/' do
  'CareDox Simple API test v1.0. Call "/immunization_status" with the numeric GET parameter "person-id"'
end

# Calling http://imm.caredox.com/immunization_status?person-id=123456
# Returns something like:
# { 
#  "status": “out-of-date”, 
#  “severity”: “high”
# } 
get '/immunization_status' do
  content_type :json
  id = params[:person_id].to_i
  response = {}
  response[:person_id] = id
  response[:status] = $statuses[id % 2]

  if response[:status] == 'out-of-date' then response[:severity] = $severeties[(id % 8)/2 + 1] else response[:severity] = 'normal' end

  json response
end
