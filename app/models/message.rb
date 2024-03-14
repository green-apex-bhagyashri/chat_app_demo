class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id, optional:true
  has_many_attached :images
end
