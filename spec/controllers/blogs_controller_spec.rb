require 'spec_helper'

describe BlogsController do
  render_views

  let(:blog) { Factory(:blog) }

  describe "POST create" do
    it "should be successful" do
      post 'create', :blog => Factory.attributes_for(:blog)
      response.should be_success
      blog = assigns[:blog]
      blog.should be_valid
    end
  end


  describe "Blog" do
    describe "GET 'unsubscribe' with a token" do
      it "should be successful" do
        get 'unsubscribe', :token => blog.token
        response.should be_success
        blog = assigns[:blog]

        blog.deleted_at?.should be_present

        response.body.should include('success')
      end
    end

    describe "GET 'unsubscribe' with a wrong token" do
      it "should be not successful" do
        get 'unsubscribe', :token => 'not good'
        response.should be_success
        blog = assigns[:blog]

        blog.should be_nil

        response.body.should include('could not')
      end
    end
  end

end
