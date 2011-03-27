class LandingController < ApplicationController
  def index
    @blog = Blog.new
  end

  def signup
    @blog = Blog.new(params[:blog])
    if @blog.save
    else
      flash[:error] = "Could not regsiter your account."
      flash[:error] = @blog.errors.full_messages
      redirect_to root_path
    end
  end
end
