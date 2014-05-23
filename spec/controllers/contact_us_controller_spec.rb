require 'spec_helper'

describe ContactUsController do

  describe 'GET #index' do 

    it 'responds with a HTTP 200 status code' do 
      get :index
      expect(response).to be_success
      expect(response.code).to eq("200")
    end

  end

end
