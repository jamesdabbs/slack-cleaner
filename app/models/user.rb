class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack]

  validates :slack_id, presence: true, uniqueness: true

  def slack_token
    slack_data["credentials"]["token"]
  end
end
