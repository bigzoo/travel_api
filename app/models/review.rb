class Review < ApplicationRecord
  validates :name, :content, :author_full_name, :author_user_name, :rating, :city, :country, presence: true
  def self.country_search(country)
    # Search using country and downcase so as to find lowercase attributes also.
    Review.where("lower(country) like ?", "#{country.downcase}")
  end

  def self.city_search(city)
    # Search using city and downcase so as to find lowercase attributes also.
    Review.where("lower(city) like ?", "#{city.downcase}")
  end
end
