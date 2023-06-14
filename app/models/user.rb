class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy # if user is deleted, delete all associated posts
  has_many :comments, dependent: :destroy # if user is deleted, delete all associated comments

  has_many :notifications, as: :recipient, dependent: :destroy # if user is deleted, delete all associated notifications

  def self.ransackable_attributes(_ = nil)
    %w[email name]
  end
end
