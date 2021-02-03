class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComments.new(book_comment_params)
    @post_comment.post_id = current_user.id
    @post_comment.save
    redirect_to posts_path(@post)
  end

  def destroy
   @post = Post.find(params[@post_id])
   comment = @post.post.find(params[:id])
   comment.destroy
  end
end
