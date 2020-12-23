class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to "/posts/#{@comment.post.id}"
    else
      flash[:notice] = "コメントを(140文字以内で)入力してください。"
      redirect_to "/posts/#{@comment.post.id}"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
