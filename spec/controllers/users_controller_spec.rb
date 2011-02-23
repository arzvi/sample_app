require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  
    it "should have correct title" do
      get 'new'
      response.should have_selector('title',:content => "Sign up") 
    end
  end
  
  describe "GET 'show'" do
    
    before(:each) do 
      @user = Factory(:user)
    end
    
    it "should be successful" do 
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do 
      get :show, :id => @user
      assigns(:user).should == @user   #assigns - provided by rspec via underlying Test::Unit library
    end
    
  end

end
