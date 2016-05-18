# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
use Rack::Health, path: '/_status/healthz'
run Rails.application
