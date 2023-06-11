class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.create(comment_params.merge(user: current_user))

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment was not created.'
    end

    redirect_to post_path(@post)
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      flash[:notice] = 'Comment was successfully deleted.'
    else
      flash[:alert] = 'Comment was not deleted.'
    end

    redirect_to post_path(@post)
  end

  def update
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
      else
        format.html { redirect_to post_path(@post), alert: 'Comment was not updated.' }
      end
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
