class ReviewSerializer < ActiveModel::Serializer
  attributes :name, :content, :author_full_name, :author_user_name, :rating, :city, :country
end
