class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destoy]
  before_action :move_to_index, only: [:edit, :update, :destoy]
  
  def index
    @posts = Post.all.includes(:user).order(id: "DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def move_to_index
    unless user_signed_in? && current_user.id == @post.user_id
      redirect_to root_path
    end
  end

end
