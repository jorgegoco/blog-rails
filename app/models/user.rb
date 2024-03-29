class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy # if user is deleted, delete all associated posts
  has_many :comments, dependent: :destroy # if user is deleted, delete all associated comments

  has_many :notifications, as: :recipient, dependent: :destroy # if user is deleted, delete all associated notifications

  has_one_attached :avatar, dependent: :destroy # if user is deleted, delete all associated avatars

  has_one :address, dependent: :destroy, inverse_of: :user, autosave: true

  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?

  # Class level accessor http://apidock.com/rails/Class/cattr_accessor
  cattr_accessor :form_steps do
    %w[sign_up set_name set_address find_users]
  end

  # Instance level accessor http://apidock.com/ruby/Module/attr_accessor
  attr_accessor :form_step

  # rubocop:disable Lint/DuplicateMethods
  def form_step
    @form_step ||= 'sign_up'
  end
  # rubocop:enable Lint/DuplicateMethods

  with_options if: -> { required_for_step?('set_name') } do |step|
    step.validates :first_name, presence: true
    step.validates :last_name, presence: true
  end

  validates_associated :address, if: -> { required_for_step?('set_address') }

  def full_name
    "#{first_name&.capitalize} #{last_name&.capitalize}"
  end

  accepts_nested_attributes_for :address, allow_destroy: true

  def required_for_step?(step)
    # All fields are required if no form step is present
    form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    form_steps.index(step.to_s) <= form_steps.index(form_step.to_s)
  end

  def self.ransackable_attributes(_ = nil)
    %w[email first_name last_name]
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
