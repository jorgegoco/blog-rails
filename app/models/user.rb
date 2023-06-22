class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy # if user is deleted, delete all associated posts
  has_many :comments, dependent: :destroy # if user is deleted, delete all associated comments

  has_many :notifications, as: :recipient, dependent: :destroy # if user is deleted, delete all associated notifications

  has_one :address, dependent: :destroy, inverse_of: :user, autosave: true 

  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?

  cattr_accessor :form_steps do
    %w[sign_up set_name set_address find_users]
  end

  attr_accessor :form_step

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  accepts_nested_attributes_for :address, allow_destroy: true

  def self.ransackable_attributes(_ = nil)
    %w[email first_name last_name]
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
