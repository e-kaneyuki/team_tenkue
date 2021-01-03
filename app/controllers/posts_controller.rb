class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show,:edit,:update,:destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.includes(:user).order(id: "DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render "new"
    end
  end

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

  def show
    @comment = Comment.new
    @comments = @post.comments.all.includes(:user).order(id: 'DESC')
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @post.user_id
      redirect_to root_path
    end
  end
end
