class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected 

  def get_current_user
    @current_user ||= Admin.find(session[:id]) if session[:id]
  end

  helper_method :get_current_user

  private

  def authenticated?

    if session[:id].nil?
      session[:last_path] = request.env['PATH_INFO']
      redirect_to admin_login_index_path
    else
      self.get_current_user
      return true
    end

  end

end
