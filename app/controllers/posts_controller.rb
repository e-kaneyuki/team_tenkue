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

    if @post.save
      redirect_to controller: :posts, action: :index
    else
      render "new"
    end

  end

  begin
    create
  rescue => error

    puts error

  end

  private
    def post_params
      params.require(:post).permit(:content).merge(user_id: current_user.id)
    end
end
