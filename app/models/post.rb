class Post < ApplicationRecord
  attr_accessor :post_images

  validates :text, presence: true

  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_one_attached :post_image
end
