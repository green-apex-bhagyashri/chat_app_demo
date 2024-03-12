class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :chat, :user, :image

  def user
    user = object.user
  end
  def chat
    user = object.chat
  end
  def image
    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true) if object.image.attached?
  end
end
