class Shop < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  attr_accessor :shop_images

  belongs_to :shop_category
  belongs_to :user

  has_one_attached :shop_image
end
