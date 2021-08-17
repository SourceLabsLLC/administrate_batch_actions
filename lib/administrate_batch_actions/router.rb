require 'administrate'

module AdministrateBatchActions
  class Router
    def self.call(*args)
      new(*args).call
    end

    def initialize(rails_router, administrate_controllers_path: nil)
      @rails_router = rails_router
      @administrate_controllers = controllers_for(administrate_controllers_path)
    end

    def call
      administrate_controllers.each do |controller|
        controller
          .instance_methods
          .select { |m| m[/.+_batch_action$/] }
          .each { |method_name| register_route(controller, method_name) }
      end
    end

    private

    def register_route(controller, method_name)
      resource = controller.name.demodulize.underscore.delete_suffix('_controller')

      rails_router.resources resource.to_sym do
        rails_router.post method_name.to_sym, on: :collection
      end
    end

    def controllers_for(path)
      path ||= Rails.root.join('app', 'controllers', 'admin', '**/*.rb')

      Dir[path].each do |file|
        require_dependency file
      end

      ::Administrate::ApplicationController.descendants
    end

    attr_reader :rails_router, :administrate_controllers
  end
end
