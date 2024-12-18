class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  def user_session_id
    if Current.session
      Session.first.user_id
    end
  end

  def current_user
    User.find_by(id: user_session_id)
  end
end
