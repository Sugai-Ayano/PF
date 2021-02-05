class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
   @post = Post.find(params[@post_id])
   post_comment = @post.post.find(params[:id])
   post_comment.destroy
  end

  private
  def post_comment_params
    params.require(:comment).permit(:content)
  end
end
