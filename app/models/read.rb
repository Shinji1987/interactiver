class Read < ApplicationRecord
  belongs_to :message

  validates_uniqueness_of :message_id
end