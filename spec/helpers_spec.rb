require 'rails_helper'

RSpec.describe 'Helpers', type: :helper do
  def render_html(html)
    Capybara.string(html)
  end

  it 'renders action button (default)' do
    html = render_html(helper.administrate_batch_actions_button('Delete All', '/'))

    expect(html).to have_css('form.button_to[method="post"][action="/"][data-turbo="false"]')
    expect(html).to have_css('form button.btn.button[type="submit"][disabled][data-batch-action-option="button"]', text: 'Delete All')
    expect(html).to have_no_css('button[data-batch-action-confirm]')
  end

  it 'renders action button (with class)' do
    html = render_html(helper.administrate_batch_actions_button('Delete All', '/', class: 'button text-danger'))

    expect(html).to have_css('button.btn.button.text-danger', text: 'Delete All')
  end

  it 'renders action button (with confirm window)' do
    html = render_html(helper.administrate_batch_actions_button('Delete All', '/', confirm: 'Are you sure to do this?'))

    expect(html).to have_css('button.btn.button', text: 'Delete All')
    expect(html).to have_css('button[data-batch-action-confirm="Are you sure to do this?"]')
    expect(html).to have_no_css('[data-confirm]')
  end

  it 'renders action button (keeps query params in the path)' do
    html = render_html(helper.administrate_batch_actions_button('Delete All', '/?scope=active'))

    expect(html).to have_css('form[action="/?scope=active"]')
  end

  it 'renders select all' do
    html = render_html(helper.administrate_batch_actions_select_all)

    expect(html).to have_css('th input[type="checkbox"][data-batch-action-option="select_all"]')
  end

  it 'renders checkbox' do
    html = render_html(helper.administrate_batch_actions_checkbox(1))

    expect(html).to have_css('td input[type="checkbox"][value="1"][data-batch-action-option="checkbox"]')
  end
end
