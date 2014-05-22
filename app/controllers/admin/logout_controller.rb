class Admin::LogoutController < ApplicationController

  before_action :authenticated?

  def index
    session[:id] = nil
    redirect_to admin_login_index_path
  end

end
