class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  before_action :resume_session, only: :new

  rate_limit to: 5, within: 1.hour, only: :create, with: -> {
    Rails.logger.info "Rate limit exceeded for IP: #{request.remote_ip}"
    redirect_to new_session_url, alert: "Try again later."
  }

  def new
    redirect_to root_url, notice: "You are already signed in." if authenticated?
    @user = User.new
  end

  def create
    user = User.new(registration_params)
    if user.save
      Rails.logger.info "User created: #{user.email_address}"
      start_new_session_for user
      Rails.logger.info "User session: #{Current.session}"
      redirect_to after_authentication_url, notice: "Welcome!"
    else
      redirect_to new_registration_url, alert: "Try another email address or password."
    end
  end

  private
  def registration_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end

  def current_user
    @session = Session.all
  end
end
