class ChannelsController < ApplicationController
  def index
    @channels = slack.channels
    @groups   = slack.groups
  end

  def destroy
    slack.clear_channel params[:id]
    redirect_back fallback_location: root_path
  rescue => e
    redirect_back fallback_location: root_path, danger: e.message
  end
end
