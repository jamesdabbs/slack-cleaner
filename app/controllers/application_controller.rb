class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

  def slack
    @slack ||= Slack.new(current_user)
  end
end
