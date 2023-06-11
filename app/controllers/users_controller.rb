class UsersController < ApplicationController
  before_action :set_user

  def profile
    return if current_user.nil? || current_user == @user
    return if session[:viewed_user_ids]&.include?(@user.id)

    @user.increment!(:views)
    session[:viewed_user_ids] ||= []
    session[:viewed_user_ids] << @user.id
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
