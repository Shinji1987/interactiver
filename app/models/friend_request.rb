class FriendRequest < ApplicationRecord
  validates_uniqueness_of :from_user_id, scope: :to_user_id

  belongs_to :user, optional: true
end
