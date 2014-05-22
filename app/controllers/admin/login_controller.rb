class Admin::LoginController < ApplicationController

  def create

    admin = Admin.where(:email => params[:email].downcase ).first

    if admin and admin.authenticate(params[:password])
      session[:id] = admin.id
      
      if session[:last_path]
        path = session[:last_path]
        session.delete(:last_path)
        redirect_to path
      else
        redirect_to admin_dashboard_index_path
      end

    else
      flash[:error] = "Email or password do not match"
      redirect_to admin_login_index_path
    end

  end

  def index
  end

end
