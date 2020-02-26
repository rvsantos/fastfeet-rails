class RecipientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :street, :city, :state, :complement, :zip_code
end
