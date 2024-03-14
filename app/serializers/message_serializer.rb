class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :chat, :user, :images

  def user
    # user = object.user
    ActiveModelSerializers::Adapter::Json.new(UserSerializer.new(object.user)).serializable_hash
  end

  def chat
    user = object.chat
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
