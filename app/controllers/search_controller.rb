class SearchController < ApplicationController
  def index
    @query = Post.ransack(params[:q])
    @posts = @query.result.includes(:user, :rich_text_body, :category)
  end
end
