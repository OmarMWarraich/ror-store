class UnsubscribesController < ApplicationController
  allow_unauthenticated_access
  before_action :set_susbcriber

  def show
    @subscriber&.destroy
    redirect_to root_path, notice: "You have been unsubscribed."
  end

  private

  def set_susbcriber
    @subscriber = Subscriber.find_by_token_for(:unsubscribe, params[:token])
  end
end
