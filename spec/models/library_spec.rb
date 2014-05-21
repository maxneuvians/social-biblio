require 'spec_helper'

describe Library do
  
  it 'should not be valid without a twitter_id' do 

    library = FactoryGirl.build(:library, :twitter_id => nil)
    library.should_not be_valid

  end

  it 'should not be valid without a username' do 

    library = FactoryGirl.build(:library, :username => nil)
    library.should_not be_valid

  end

  it 'should not be valid is there already is a library with the same twitter_id' do 

    library_a = FactoryGirl.create(:library, :twitter_id => '12345')
    library_b = FactoryGirl.build(:library, :twitter_id => '12345')
    library_b.should_not be_valid

  end

  it 'should not be valid is there already is a library with the same username' do 

    library_a = FactoryGirl.create(:library, :username => '12345')
    library_b = FactoryGirl.build(:library, :username => '12345')
    library_b.should_not be_valid

  end

end
