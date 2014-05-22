require 'spec_helper'

describe Admin::LibrariesController do

  describe 'GET #index' do 

    it 'responds with a HTTP 200 status code if there is a valid admin' do 
      admin = FactoryGirl.create(:admin)
      session[:id] = admin.id
      get :index
      expect(response).to be_success
      expect(response.code).to eq("200")
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
