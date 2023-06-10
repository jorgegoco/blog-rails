class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create, :destroy]

  def create
    @comment = @post.comments.create(comment_params.merge(user: current_user))

    if @comment.save
      flash[:notice] = "Comment was successfully created."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment was not created."
      redirect_to post_path(@post)
    end  
  end

  def destroy 
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      flash[:notice] = "Comment was successfully deleted."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment was not deleted."
      redirect_to post_path(@post)
    end
  end

  private

  def set_post  
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end


end
