class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user
  before_action :set_categories
  before_action :set_query

  def set_query
    @query = Post.ransack(params[:q])
  end

  # rubocop:disable Naming/PredicateName
  def is_admin?
    redirect_to root_path, alert: "You don't have permission to do that." unless current_user&.admin?
  end
  # rubocop:enable Naming/PredicateName

  private

  def set_categories
    @nav_categories = Category.where(display_in_nav: true).order(:name)
  end

  def set_notifications
    notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end
end
