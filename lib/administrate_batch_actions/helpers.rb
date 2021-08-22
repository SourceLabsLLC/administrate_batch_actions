module AdministrateBatchActions
  module Helpers
    def administrate_batch_actions_button(name, path, html_options = {class: 'button'})
      render partial: 'shared/administrate_batch_actions/button',
            locals: { name: name, path: path, html_options: html_options }
    end

    def administrate_batch_actions_select_all
      render partial: 'shared/administrate_batch_actions/select_all'
    end

    def administrate_batch_actions_checkbox(value)
      render partial: 'shared/administrate_batch_actions/checkbox',
            locals: { value: value }
    end
  end
end