class CommentsController < ApplicationController

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
  end

  def destroy
    # <byebug>
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end


  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def destroy
    @comment = Comment.find(comment_params)
    if @comment.destroy
      redirect_to post_path(@post), notice: 'コメントを削除しました'
    else
      flash.now[:alert] = 'コメント削除に失敗しました'
      render post_path(@post)
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, :comment_params, post_id: params[:post_id, :id])
  end
end
