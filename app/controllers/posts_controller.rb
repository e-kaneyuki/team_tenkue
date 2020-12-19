class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show,:edit,:update,:destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all.includes(:user).order(id: "DESC")
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "「#{@post.content}」に編集しました"
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
      @post.destroy
      flash[:danger] = "「#{@post.content}」を削除しました。"
      redirect_to posts_url
  end

  private
  
  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @post.user_id
      redirect_to root_path
    end
  end
end