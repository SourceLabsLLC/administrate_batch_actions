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
      .instance_methods
      .select { |m| m[/.+_batch_action$/] }
      .each do |method_name|
        resource = controller.name.demodulize.underscore.delete_suffix('_controller')

        resources resource.to_sym do
          post method_name.to_sym,
            on: :collection,
            controller: controller.name.underscore.delete_suffix('_controller')
        end
    end
  end
end
