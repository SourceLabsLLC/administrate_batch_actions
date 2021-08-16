require 'rails'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/dependencies'
require 'administrate/engine'

# require 'administrate_batch_actions/router'
require 'administrate_batch_actions/helpers'
require 'administrate_batch_actions/version'

module AdministrateBatchActions
  class Engine < ::Rails::Engine
    Administrate::Engine.add_javascript 'administrate_batch_actions/script'

    initializer "administrate_batch_actions.engine" do |app|
      ActionView::Base.send :include, AdministrateBatchActions::Helpers
      # binding.pry
      # AdministrateBatchActions::Router.new(Rails.application.routes.router).call
    end
  end
end
