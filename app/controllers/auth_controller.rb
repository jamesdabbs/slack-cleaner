class AuthController < Devise::OmniauthCallbacksController
  def slack
    auth = request.env["omniauth.auth"]

    user = User.where(slack_id: auth.uid).first_or_initialize
    user.update! \
      email:      "slack#{auth.info.user_id}@example.com",
      password:   SecureRandom.hex(32),
      slack_data: auth.to_h

    sign_in user
    redirect_to root_path
  end
end
