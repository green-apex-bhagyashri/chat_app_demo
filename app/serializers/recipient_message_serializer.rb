class RecipientMessageSerializer < ActiveModel::Serializer
  # include jsonapi-serializer::ObjectSerializer
  attributes :id, :content, :chat, :sender, :recipient,:images

  def sender
    ActiveModelSerializers::Adapter::Json.new(UserSerializer.new(object.user)).serializable_hash
  end
  def recipient
    receiver = User.find_by(id: object.recipient_id)
    ActiveModelSerializers::Adapter::Json.new(UserSerializer.new(receiver)).serializable_hash
  end
  def chat
    chat = object.chat
  end

  def images
    images = []
    if object.images.present?
      object.images.each do |image|
        images << {url: Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true), id: image.id, file_name: image.filename }
      end
      images
    else
      []
    end
  end
end
