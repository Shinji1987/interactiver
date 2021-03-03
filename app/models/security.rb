class Security < ApplicationRecord
  belongs_to :user, :optional => true

  validates :block_user_id, :presence => true
  validates :blocked_user_id, :presence => true
end
