module Admin
  class DummyController < Administrate::ApplicationController
    def dummy_batch_action; end

    def not_valid; end
  end
end
