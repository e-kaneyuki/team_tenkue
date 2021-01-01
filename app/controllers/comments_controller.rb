
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
  # byebug
  def edit
    # byebug
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    render "posts/show"
    # @comment = Comment.find(params[:id])
    # redirect_to post_path(params[:post_id])
    # ↑ここの設定次第です ここの設定でどこの画面にとんで編集をするのかを設定したい。
    # ↑それが決まれば次のメソッドでupdateができるはず。
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(params[:post_id])
      #↑これredirect_to request.referera の表現を少し変えてしっかり変更が反映されるようにしましょう！
      #データベースには変更の受け渡しはできている
    else
      flash[:alert] = "更新できませんでした"
      render "posts/show"
    end
  end
  def destroy
    # <byebug>
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end

end
