class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :text
    validates :category_id
    validates :condition_id
    validates :postage_id
    validates :prefecture_id
    validates :day_id
    validates :price
  end

  belings_to :user
  has_one_attached :image
end
