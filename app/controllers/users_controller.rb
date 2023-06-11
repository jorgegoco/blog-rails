class UsersController < ApplicationController
  before_action :set_user

  def profile
  if current_user && current_user != @user # check if user is logged in and not viewing their own profile
    unless session[:viewed_user_ids]&.include?(@user.id) # check if the viewed user's id is already stored in the session
      @user.increment!(:views) # increment the views count by 1
      session[:viewed_user_ids] ||= [] # initialize the array if it doesn't exist
      session[:viewed_user_ids] << @user.id # add the viewed user's id to the session array
    end
  end
end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
