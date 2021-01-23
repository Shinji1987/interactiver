class Post < ApplicationRecord
  attr_accessor :post_images

  validates :text, presence: true

  belongs_to :user
  has_many :comments
  has_one_attached :post_image
end
