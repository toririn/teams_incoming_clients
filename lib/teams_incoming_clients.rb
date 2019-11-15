require "teams_incoming_clients/initialize"

module TeamsIncomingClients
end

Dir[File.dirname(__FILE__) + '/teams_incoming_clients/**/*.rb'].each {|file| require file }
