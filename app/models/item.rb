class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :day

  with_options presence: true do
    validates :image
    validates :name
    validates :text
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :postage_id
      validates :prefecture_id
      validates :day_id
    end
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }, format: { with: /\A[0-9]+\z/ }
  end
end