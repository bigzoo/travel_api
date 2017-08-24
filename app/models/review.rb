class Review < ApplicationRecord
  validates :content, :author_full_name, :author_user_name, :rating, :city, :country, presence: true
end
