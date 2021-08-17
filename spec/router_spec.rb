require 'spec_helper'

RSpec.describe AdministrateBatchActions::Router do
  describe '.call' do
    let(:rails_router) do
      double(
        :rails_router,
        resources: true,
        get: true
      )
    end

    let(:administrate_controllers_path) { './spec/dummy/controllers/**/*.rb' }

    subject(:set_route) do
      described_class.call(
        rails_router,
        administrate_controllers_path: administrate_controllers_path
      )
    end

    it 'calls the rails router to create routes' do
      expect(rails_router).to receive(:resources)
        .with(:dummy)
        .and_yield

      expect(rails_router).to receive(:post)
        .with(:dummy_batch_action, on: :collection)

      set_route
    end
  end
end
