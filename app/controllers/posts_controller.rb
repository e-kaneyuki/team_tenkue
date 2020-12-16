class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:user).order(id: "DESC")
  end
end