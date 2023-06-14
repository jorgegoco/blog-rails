class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { minimum: 10, maximum: 1000 }
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user, dependent: :destroy

  private

  def self.ransackable_attributes(auth_object = nil)
    ["body", "title"]
    end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
