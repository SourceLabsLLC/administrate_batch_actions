require 'rails'
require 'active_support'
require 'active_support/core_ext'
require 'administrate/engine'

require 'administrate_batch_actions/helpers'
require 'administrate_batch_actions/version'

module AdministrateBatchActions
  # Controller namespace(s) to scan for `*_batch_action` methods, i.e.
  # app/controllers/<namespace>/**/*.rb. Accepts a symbol or an array.
  mattr_accessor :namespace, default: :admin

  class Engine < ::Rails::Engine
    # Propshaft serves every engine asset automatically; Sprockets needs it listed
    initializer "administrate_batch_actions.assets.precompile" do |app|
      if defined?(Sprockets::Railtie)
        app.config.assets.precompile += [
          "administrate_batch_actions/script.js"
        ]
      end
    end

    Administrate::Engine.add_javascript 'administrate_batch_actions/script'

    initializer "administrate_batch_actions.helpers" do
      ActiveSupport.on_load(:action_view) do
        include AdministrateBatchActions::Helpers
      end
    end
  end
end
