require 'spec_helper'

describe Admin::LogoutController do

  describe 'GET #index' do 

    it 'sets the session[:id] to nil if there is a valid admin' do 
      admin = FactoryGirl.create(:admin)
      session[:id] = admin.id
      get :index
      expect(session[:id]).to eql(nil)
    end

    it 'redirects to login if there is a valid admin' do 
      admin = FactoryGirl.create(:admin)
      session[:id] = admin.id
      get :index
      response.should be_redirect
      response.should redirect_to( admin_login_index_path )
    end

    it 'redirects to login if there is no valid admin' do 
      admin = FactoryGirl.create(:admin)
      session[:id] = nil
      get :index
      response.should be_redirect
      response.should redirect_to( admin_login_index_path )
    end

  end

end
