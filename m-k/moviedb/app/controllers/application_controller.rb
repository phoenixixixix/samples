# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authenticate_admin_user
    authenticate_user!

    redirect_to root_path unless current_user.admin?
  end
end
