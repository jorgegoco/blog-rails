class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy # if user is deleted, delete all associated posts
  has_many :comments, dependent: :destroy # if user is deleted, delete all associated comments

  has_many :notifications, as: :recipient, dependent: :destroy # if user is deleted, delete all associated notifications

  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def self.ransackable_attributes(_ = nil)
    %w[email name]
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
