require 'spec_helper'

describe PagesController do
  render_views
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have correct title" do
      get 'home'
      response.should have_selector('title', :content => "RoR tutorial | Home")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have correct title" do
      get 'about'
      response.should have_selector('title', :content => "RoR tutorial | About")
    end
  end
  
  describe "GET 'contact'" do
    it "should be_successful" do 
      get 'contact'
      response.should be_success
    end
    
    it "should have correct title" do
      get 'contact'
      response.should have_selector('title',:content => "RoR tutorial | Contact")
    end
  end
  
end
