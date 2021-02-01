class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :chat, optional: true
  has_one    :read, dependent: :destroy
end
