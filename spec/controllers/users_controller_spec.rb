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
    
    it "should have correct tite" do 
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name )
      
    end
    
    it "should have user's name" do 
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name )
    end
    
    it "should have a profile image" do 
      get :show, :id => @user
      response.should have_selector("h1>img", :class=> "gravatar") # to show that the image tag is under the h1 tag, and it contains the class as gravatar
    end
    
  end
  
  describe "POST 'create'" do 
    describe "failure" do
      
      before(:each) do 
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => ""}
      end
      
      it "should not create a user" do 
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end
      
      it "should render the 'new' page" do 
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do 
      before(:each) do
        @attr= { :name => "Arun Srini", :email => "arunrocks@gmail.com", :password=>"foo",
          :password_confirmation => "foo"}
      end
      
      it "should create an user" do
        lambda do 
          post :create, :user => @attr
        end.should change(:user.count).by(1)
      end
      
      it "should redirect to user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      
    end
  end
end

