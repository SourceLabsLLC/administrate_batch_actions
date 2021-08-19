require './rails_helper'

RSpec.describe 'Routes', type: :routing do
  it 'has route to the batch action' do
    expect(post: '/admin/dummy/dummy_batch_action').to route_to(
      controller: 'admin/dummy',
      action: 'dummy_batch_action'
    )
  end
end
