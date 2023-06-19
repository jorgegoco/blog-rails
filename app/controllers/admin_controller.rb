class AdminController < ApplicationController
  def index; end

  def posts
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def comments
    @comments = Comment.all.includes(:user, :post).order(created_at: :desc)
  end

  def users
    @users = User.all.order(created_at: :desc)
  end

  def show_post
    @post = Post.includes(:user, comments: { user: {}, rich_text_body: {} }).find(params[:id])
  end

  def show_comment
    @comment = Comment.includes(:user, :post).find(params[:id])
    @post = @comment.post
  end
end
