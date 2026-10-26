Rails.application.routes.draw do

  def controllers_for(namespaces)
    Array(namespaces).each do |namespace|
      path = Rails.root.join('app', 'controllers', namespace.to_s)
      Rails.autoloaders.main.eager_load_dir(path) if path.directory?
    end

    ::Administrate::ApplicationController.descendants.uniq
  end

  namespaces = Array(AdministrateBatchActions.namespace).map(&:to_s)

  controllers_for(namespaces).each do |controller|
    controller_path = controller.controller_path
    namespace = namespaces.find { |ns| controller_path.start_with?("#{ns}/") }
    next unless namespace

    controller
      .action_methods
      .select { |m| m.end_with?('_batch_action') }
      .each do |method_name|
        prefixless_controller_path = controller_path.delete_prefix("#{namespace}/")

        scope path: namespace, as: namespace do
          post "administrate_batch_actions/#{prefixless_controller_path}/#{method_name}",
            to: "#{controller_path}##{method_name}",
            as: "#{method_name}_#{prefixless_controller_path}"
        end
    end
  end
end
