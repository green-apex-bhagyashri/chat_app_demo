class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id, optional:true
  has_one_attached :image
end
