class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :text
    validates :category_id numericality: { other_than: 1 }
    validates :condition_id numericality: { other_than: 1 }
    validates :postage_id numericality: { other_than: 1 }
    validates :prefecture_id numericality: { other_than: 1 }
    validates :day_id numericality: { other_than: 1 }
    validates :price
  end

  belings_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :day
end