class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user

  protected

  def authenticate_user
    if current_user
      true
    else
      redirect_to(:controller => 'sessions', :action => 'new')
      false
    end
  end

  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end
