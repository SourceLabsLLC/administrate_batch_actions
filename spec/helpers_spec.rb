require 'rails_helper'

RSpec.describe 'Helpers', type: :helper do
  it 'renders action button (default)' do
    expect(helper.administrate_batch_actions_button('Delete All', '/')).to include '<a class="button" data-batch-action-option="button" rel="nofollow" data-method="post" href="/">Delete All</a>'
  end

  it 'renders action button (with class)' do
    expect(helper.administrate_batch_actions_button('Delete All', '/', class: 'button text-danger')).to include '<a class="button text-danger" data-batch-action-option="button" rel="nofollow" data-method="post" href="/">Delete All</a>'
  end

  it 'renders action button (with confirm window)' do
    expect(helper.administrate_batch_actions_button('Delete All', '/', class: 'button', confirm: 'Are you sure to do this?')).to include '<a class="button" data-batch-action-option="button" data-confirm="Are you sure to do this?" rel="nofollow" data-method="post" href="/">Delete All</a>'
  end

  it 'renders select all' do
    expect(helper.administrate_batch_actions_select_all).to include '<input type="checkbox" data-batch-action-option="select_all" />'
  end

  it 'renders checkbox' do
    expect(helper.administrate_batch_actions_checkbox(1)).to include '<input type="checkbox" value="1" data-batch-action-option="checkbox" />'
  end
end
