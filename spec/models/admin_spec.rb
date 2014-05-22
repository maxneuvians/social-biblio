require 'spec_helper'

describe Admin do
  
  it 'should not be valid without an email' do 

    admin = FactoryGirl.build(:admin, :email => nil)
    admin.should_not be_valid

  end

  it 'should not be valid without a password' do 

    admin = FactoryGirl.build(:admin, :password => nil)
    admin.should_not be_valid

  end

  it 'should not be valid without a password_confirmation' do 

    admin = FactoryGirl.build(:admin, :password_confirmation => nil)
    admin.should_not be_valid

  end

  it 'should not be valid without a password_digest' do 

    admin = FactoryGirl.build(:admin, :password_digest => nil)
    admin.should_not be_valid

  end

  it 'should not be valid if password does not match password_confirmation' do 

    admin = FactoryGirl.build(:admin, :password => 'foo', :password_confirmation => 'bar')
    admin.should_not be_valid

  end

  it 'should not be valid if there already is a admin with the same email' do 

    admin_a = FactoryGirl.create(:admin, :email => 'test@test.com')
    admin_b = FactoryGirl.build(:admin, :email => 'test@test.com')
    admin_b.should_not be_valid

  end

  it 'should not be valid if the email is not in the proper format' do 

    admin = FactoryGirl.build(:admin, :email => 'test-bad-format')
    admin.should_not be_valid

  end

  it 'should not be valid if the password is to short' do 

    admin = FactoryGirl.build(:admin, :password => 'short', :password_confirmation => 'short')
    admin.should_not be_valid

  end

end
