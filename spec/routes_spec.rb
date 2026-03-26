require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  it 'has route to the batch action' do
    expect(admin_dummy_batch_action_dummy_path).to eq('/admin/dummy/dummy_batch_action')
    expect(post: admin_dummy_batch_action_dummy_path).to route_to(
      controller: 'admin/dummy',
      action: 'dummy_batch_action'
    )
  end

  it 'has route to the batch action in a nested namespace' do
    expect(admin_my_batch_action_nested_namespace_path).to eq('/admin/nested/namespace/my_batch_action')
    expect(post: admin_my_batch_action_nested_namespace_path).to route_to(
      controller: 'admin/nested/namespace',
      action: 'my_batch_action'
    )
  end
end
