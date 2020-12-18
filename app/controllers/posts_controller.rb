class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.includes(:user).order(id: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    # byebug

    @post.save!

    redirect_to controller: :posts, action: :index
    # if @post.save!
    #   redirect_to controller: :post, action: :index
    # else
    #   render "new"
    # end
  end

  private
    def post_params
      # byebug
      params.require(:post).permit(:content).merge(user_id: current_user.id)
    end
end
