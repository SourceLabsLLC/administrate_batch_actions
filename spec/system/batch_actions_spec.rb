require 'rails_helper'

RSpec.describe 'Batch actions', type: :system do
  before { visit '/batch' }

  def checkbox(id)
    find("input[data-batch-action-option='checkbox'][value='#{id}']")
  end

  it 'keeps the buttons disabled until a row is selected' do
    expect(page).to have_button('Delete', disabled: true)

    checkbox(1).click
    expect(page).to have_button('Delete', disabled: false)

    checkbox(1).click
    expect(page).to have_button('Delete', disabled: true)
  end

  it 'submits the selected ids and keeps query params in the path' do
    checkbox(1).click
    checkbox(3).click

    accept_confirm('Are you sure?') { click_button 'Delete' }

    expect(page).to have_content('ids=1,3 scope=active')
  end

  it 'does not submit when the confirm is dismissed' do
    checkbox(2).click

    dismiss_confirm('Are you sure?') { click_button 'Delete' }

    expect(page).to have_current_path('/batch')
  end

  it 'selects every row with select all, without asking to confirm' do
    find("input[data-batch-action-option='select_all']").click

    click_button 'Archive'

    expect(page).to have_content('archived=1,2,3')
  end

  it 'does not leak globals' do
    expect(page.evaluate_script('typeof init')).to eq('undefined')
  end
end
