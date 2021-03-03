class FriendRequest < ApplicationRecord
  validates_uniqueness_of :from_user_id, :scope => :to_user_id
  validates :from_user_id, :presence => true
  validates :to_user_id, :presence => true

  belongs_to :user, :optional => true
end