require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @attr = { :name => "Dudess" , :email => "big@labowski.the", 
      :password => "onepass", :password_confirmation => "onepass"}
  end
  
  it "should create valid model given all params" do 
    User.create!(@attr)
  end 
  
  it "should require a name" do 
    no_name_attr=User.new(@attr.merge(:name => ""))
    no_name_attr.should_not be_valid
  end
  
  it "should require an email" do 
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid 
  end
  
  it "should reject names that are too long" do
    long_name_user = User.new(@attr.merge(:name => 'a' * 51))
    long_name_user.should_not be_valid 
      
  end
  it "should reject invalid email addresses" do 
    addresses = %w[ arun@lamoondotcom asrinivasan_at_hms.com arunrocks ]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate emails" do 
    User.create!(@attr)
    user_with_dup_mail = User.new(@attr)
    user_with_dup_mail.should_not be_valid
  end
  
  it "should reject duplicate emails insensitive to case" do 
    upcase_mail = @attr[:email]
    User.create!(@attr.merge(:email => upcase_mail))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
    
  it "should require password and confirmation" do 
    User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
  end
  
  it "should require a matching password confirmation" do 
    User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
  end
  
  it "should not accept short passwords" do
    short = "a" * 5
    hash = @attr.merge(:password => short, :password_confirmation => short)
    User.new(hash).should_not be_valid 
  end
  
  it "should reject long passwords" do 
    long = "a" * 41
    hash = @attr.merge(:password => long, :password_confirmation => long)
    User.new(hash).should_not be_valid
  end 
  
  
  
  # -------------new describe------------------------------------------
  describe "password encryption" do 
    before(:each) do 
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do 
    @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do 
      @user.encrypted_password.should_not be_blank
    end
  
  
    describe "has_password? method" do 
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
    
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do 
      it "should return nil if passwords don't match" do 
        wrong_password_user = User.authenticate(@attr[:email],"wrongpass")
        wrong_password_user.should be_nil
      end
      
      it "should return nil if user not found" do 
        nonexistant_user = User.authenticate("bar@foo.com",@attr[:password])
      end
      
      it "should return user object on success" do
        valid_user = User.authenticate(@attr[:email], @attr[:password])
        valid_user.should == @user
      end
    end
  end
end
