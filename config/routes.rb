Rails.application.routes.draw do

  def controllers_for(path)
    path ||= Rails.root.join('app', 'controllers', 'admin', '**/*.rb')

    Dir[path].each do |file|
      require_dependency file
    end

    ::Administrate::ApplicationController.descendants
  end

  controllers_for(nil).each do |controller|
    controller
      .action_methods
      .select { |m| m.end_with?('_batch_action') }
      .each do |method_name|
        controller_path = controller.controller_path
        prefixless_controller_path = controller_path.delete_prefix('admin/')

        scope path: :admin, as: :admin do
          post "#{prefixless_controller_path}/#{method_name}",
            to: "#{controller_path}##{method_name}",
            as: "#{method_name}_#{prefixless_controller_path}"
        end
    end
  end
end
