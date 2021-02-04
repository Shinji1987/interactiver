class Message < ApplicationRecord
  attr_accessor :message_images
  
  belongs_to :user, optional: true
  belongs_to :chat, optional: true
  has_one    :read, dependent: :destroy
  has_one_attached :message_image

  validates :content, presence: true, unless: :was_attached?

  def was_attached?
    self.message_image.attached?
  end
end