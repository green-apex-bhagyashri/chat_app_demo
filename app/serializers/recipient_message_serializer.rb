class RecipientMessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :chat, :sender, :image, :recipient

  def sender
    # user = object.user
    ActiveModelSerializers::Adapter::Json.new(UserSerializer.new(object.user)).serializable_hash
  end
  def recipient
    user = User.find_by(id: object.recipient_id)
    ActiveModelSerializers::Adapter::Json.new(UserSerializer.new(user)).serializable_hash
  end
  def chat
    user = object.chat
  end
  def image
    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.attached?
  end
end
