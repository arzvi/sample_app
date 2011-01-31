class PagesController < ApplicationController
  @@head_title = "RoR tutorial"
  def home
    @title ='Home'
    @full_title= @@head_title + " | " + @title
  end

  def about
    @title = "About"
    @full_title= @@head_title + " | " + @title
    
  end
  
  def contact
    @title = "Contact"
    @full_title= @@head_title + " | " + @title
    
  end
  def full_title 
    @full_title= @@head_title + " | " + @title
  end
  
end
