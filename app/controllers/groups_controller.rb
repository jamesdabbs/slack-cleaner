class GroupsController < ApplicationController
  def destroy
    slack.clear_group params[:id]
    redirect_back fallback_location: root_path
  rescue => e
    redirect_back fallback_location: root_path, danger: e.message
  end
end
