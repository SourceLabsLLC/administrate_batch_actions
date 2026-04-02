require 'rails_helper'

RSpec.describe 'Helpers', type: :helper do
  it 'renders action button (default)' do
    expected_html = <<~HTML
      <form class="button_to" method="post" action="/"><button class="btn button" data-batch-action-option="button" disabled="disabled" type="submit">
        Delete All
      </button></form>
    HTML

    expect(helper.administrate_batch_actions_button('Delete All', '/').squish).to include(expected_html.squish)
  end

  it 'renders action button (with class)' do
    expected_html = <<~HTML
      <form class="button_to" method="post" action="/"><button class="btn button text-danger" data-batch-action-option="button" disabled="disabled" type="submit">
        Delete All
      </button></form>
    HTML

    expect(helper.administrate_batch_actions_button('Delete All', '/', class: 'button text-danger').squish).to include(expected_html.squish)
  end

  it 'renders action button (with confirm window)' do
    expected_html = <<~HTML
      <form class="button_to" method="post" action="/"><button class="btn button" data-batch-action-option="button" data-confirm="Are you sure to do this?" disabled="disabled" type="submit">
        Delete All
      </button></form>
    HTML

    expect(helper.administrate_batch_actions_button('Delete All', '/', class: 'button', confirm: 'Are you sure to do this?').squish).to include(expected_html.squish)
  end

  it 'renders select all' do
    expect(helper.administrate_batch_actions_select_all).to include '<input type="checkbox" data-batch-action-option="select_all" />'
  end

  it 'renders checkbox' do
    expected_html = <<~HTML
      <input type="checkbox" value="1" data-batch-action-option="checkbox" />
    HTML

    expect(helper.administrate_batch_actions_checkbox(1).squish).to include(expected_html.squish)
  end
end
