class AdminController < ApplicationController
  def index
  end

  def posts
    @posts = Post.all.includes(:user, :comments).order(created_at: :desc)
  end

  def comments
    @comments = Comment.all.includes(:user, :post).order(created_at: :desc)
  end

  def users
  end

  def show_post
    @post = Post.includes(:user, :comments).find(params[:id])
  end

  def show_comment
    @comment = Comment.includes(:user, :post).find(params[:id])
    @post = @comment.post
  end
end
