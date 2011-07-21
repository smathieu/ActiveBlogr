class LandingController < ApplicationController
  def index
    @blog = Blog.new
  end
end
