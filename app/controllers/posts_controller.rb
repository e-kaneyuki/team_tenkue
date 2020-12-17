class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:user).order(id: "DESC")
  end

  def show
    @post = Post.find(params[:id])
  end
end
