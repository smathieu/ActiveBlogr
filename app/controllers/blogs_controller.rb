class BlogsController < ApplicationController
  def create
    @blog = Blog.new(params[:blog])
    if @blog.save
    else
      flash[:error] = "Could not regsiter your account."
      flash[:error] = @blog.errors.full_messages
      redirect_to root_path
    end
  end

  def unsubscribe
    @blog = Blog.find_by_token(params[:token])
    @blog.try(:destroy)
  end
end
