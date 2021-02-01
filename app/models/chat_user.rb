class ChatUser < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :chat, optional: true

  validates_uniqueness_of :created_user_id, scope: :invited_user_id
end