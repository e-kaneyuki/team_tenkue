class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.includes(:user).order(id: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to controller: :posts, action: :index
    else
      render "new"
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:content).merge(user_id: current_user.id)
    end

    def move_to_index
      unless user_signed_in? && current_user.id == @post.user_id
        redirect_to root_path
      end
    end
end
