class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, :counter_cache => :likes_count

  validates_uniqueness_of :post_id, :scope => :user_id
end