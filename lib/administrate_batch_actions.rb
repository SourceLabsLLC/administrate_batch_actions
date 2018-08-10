require 'rails'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/dependencies'
require 'administrate/engine'

require 'administrate_batch_actions/router'
require 'administrate_batch_actions/version'

module AdministrateBatchActions
  class Engine < ::Rails::Engine
  end
end
