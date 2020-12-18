class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.includes(:user).order(id: "DESC")
  end

  def new
    @post = Post.new
    # byebug
    @user = current_user
  end

  def create
    @post = Post.new(post_params)

    if @post.save!
      redirect_to controller: :post, action: :index
    else
      render "new"
    end
  end

  private
    def post_params
      # byebug
      params.require(:post).permit(:content).merge(user_id: current_user.id)
    end
end
