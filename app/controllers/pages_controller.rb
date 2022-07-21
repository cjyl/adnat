class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :check_log_in

  def home
    if user_signed_in?
      redirect_to organisations_path
    end
  end

  private

  def check_log_in
    return if user_signed_in?

    redirect_to new_user_session_url
  end
end
