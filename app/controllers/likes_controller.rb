class LikesController < ApplicationController
  def create
    if current_user
      current_user.likes.create(post_id: params[:post_id])
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "アカウント登録もしくはログインしてください"
      redirect_to new_user_session_path
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy!
    redirect_back(fallback_location: root_path)
  end
end
