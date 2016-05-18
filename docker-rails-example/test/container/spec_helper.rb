require 'infrataster/rspec'

Infrataster::Server.define(:app) do |server|
  server.address = '127.0.0.1'
end
