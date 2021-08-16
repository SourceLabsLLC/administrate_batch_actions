module AdministrateBatchActionsHelper
  def administrate_batch_actions_buttons(namespace, page)
    render partial: 'shared/administrate_batch_actions/buttons',
           locals: { namespace: namespace, page: page }
  end

  def administrate_batch_actions_select_all
    render partial: 'shared/administrate_batch_actions/select_all'
  end

  def administrate_batch_actions_checkbox(value)
    render partial: 'shared/administrate_batch_actions/checkbox',
           locals: { value: value }
  end
end
