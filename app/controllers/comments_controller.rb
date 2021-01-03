
class CommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "コメントを(140文字以内で)入力してください。"
      redirect_to post_path(@post.id)
    end
  end
  def edit
    render "posts/show"
  end
  def update
    if @comment.update(comment_params)
      flash[:notice] = "コメントを更新しました"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = 'コメントを(140文字以内で)入力してください。'
      render 'posts/show'
    end
  end
  def destroy
    @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(params[:post_id])
  end

  def ensure_correct_user
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to post_path(params[:post_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
