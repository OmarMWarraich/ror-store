require "bcrypt"

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true, on: :create, if: -> { password_digest.blank? }
  validates :password_confirmation, presence: true, on: :create, if: -> { password_digest.blank? }

  def authenticate(password)
    BCrypt::Password.new(password_digest).is_password?(password) && self
  end

  def start_new_session
    sessions.create
  end

  def end_all_sessions
    sessions.destroy_all
  end
end
