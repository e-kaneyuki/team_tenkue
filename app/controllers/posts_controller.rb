class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:user).order(id: "DESC")
  end

  def show
  end

  def edit
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to posts_url
    end
  end

  def update
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id && @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id
      @post.destroy
      flash[:danger] = "「#{@post.content}」を削除しました。"
      redirect_to posts_url
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:content)
  end

end