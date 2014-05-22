require 'spec_helper'

describe Admin::LoginController do

  describe 'POST #create' do 

    it 'authenticates a valid admin and sends them to the dashboard if there is no redirect path' do

      valid_admin = FactoryGirl.create(:admin)
      post :create, {:email => valid_admin.email, :password => valid_admin.password}
      response.should be_redirect
      response.should redirect_to( admin_dashboard_index_path )

    end

    it 'authenticates a valid admin and sends them to the chosen redirect path' do

      valid_admin = FactoryGirl.create(:admin)
      session[:last_path] = '/admin/libraries'
      post :create, {:email => valid_admin.email, :password => valid_admin.password}
      response.should be_redirect
      response.should redirect_to( admin_libraries_path )

    end

    it 'rejects an invalid admin and returns them to the login page' do 
      valid_admin = FactoryGirl.create(:admin)
      post :create, {:email => valid_admin.email, :password => nil}
      response.should be_redirect
      response.should redirect_to( admin_login_index_path )
    end

  end

  describe 'GET #index' do 

    it 'responds with a HTTP 200 status code' do 
      get :index
      expect(response).to be_success
      expect(response.code).to eq("200")
    end

  end

end
