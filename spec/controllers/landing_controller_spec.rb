require 'spec_helper'

describe LandingController do
  integrate_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST singup" do
    it "should be successful" do
      post 'signup', :blog => Factory.attributes_for(:blog)
      response.should be_success
      blog = assigns[:blog]
      blog.should be_valid
    end
  end

end
