class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    # 検索時
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.user_id = current_user.id
    unless @post_comment.save!
      render 'error'
    end
  end

  def destroy
    # コメントをfindしてdestroyを呼び出す
    # 削除したいコメントを呼び出す
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:content)
  end
end
