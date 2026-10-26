module Admin
  class DummyController < Administrate::ApplicationController
    def dummy_batch_action
      render plain: "ids=#{params[:batch_action_ids].join(',')} scope=#{params[:scope]}"
    end

    def not_valid; end
  end
end
