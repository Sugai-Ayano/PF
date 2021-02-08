class RelationshipsController < ApplicationController
  def create
    # ユーザーがフォローする
     current_user.follow(params[:user_id])
    #  current_user.follwer.create(folliwed_id: user_id)
    redirect_back(fallback_location: user_path)
  end

  def destroy
    #  ユーザーがフォローを外す
      current_user.unfollow(params[:user_id])
      redirect_back(fallback_location: user_path)
  end

　# ユーザー一覧
  def follow
      user = User.find(params[:user_id])
      @users = user.following_user
  end

  def followed
      user = User.find(params[:user_id])
      @user = user.follower_user
  end
end