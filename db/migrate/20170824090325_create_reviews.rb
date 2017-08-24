class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :content
      t.string :author_full_name
      t.string :author_user_name
      t.integer :rating , default: 0
      t.string :city
      t.string :country
    end
  end
end
