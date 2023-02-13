class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :require_login

  def current_user
    @current_user || User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if session[:user_id].nil?
      redirect_to login_path, alert: "Please log in to access that page."
    end
  end

  helper_method :current_user

end
