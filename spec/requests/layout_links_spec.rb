require 'spec_helper'

describe "LayoutLinks" do
  it "should have home at '/'" do
    get '/' do
      response.should have_selector('title',:content => "Home")
    end
  end
  
  it "should have about at '/about'" do
    get '/about' do
      response.should have_selector('title',:content => "About")
    end
  end
  
  
  it "should have contact at '/contact'" do
    get '/' do
      response.should have_selector('title',:content => "Contact")
    end
  end
  
  it "should have about at '/help'" do
    get '/about' do
      response.should have_selector('title',:content => "Help")
    end
  end
  
end
