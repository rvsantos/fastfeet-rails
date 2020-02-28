class DeliverymanSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email

  attribute :avatar do |object|
    if object.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.avatar)
    end
  end
end
