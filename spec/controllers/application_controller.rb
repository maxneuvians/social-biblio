require 'spec_helper'

describe ApplicationController do

  describe '.get_current_user' do 

    it 'returns the current user based on session[:id]' do 
      admin = FactoryGirl.create(:admin)
      session[:id] = admin.id
      subject.send(:get_current_user).should eql admin
    end

  end

end