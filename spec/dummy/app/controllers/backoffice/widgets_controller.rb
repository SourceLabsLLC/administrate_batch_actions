module Backoffice
  class WidgetsController < Administrate::ApplicationController
    def archive_batch_action
      render plain: "archived=#{params[:batch_action_ids].join(',')}"
    end
  end
end
