require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'

Bundler.require(*Rails.groups)
require "avro_turf/rails"

module Dummy
  class Application < Rails::Application
  end
end

