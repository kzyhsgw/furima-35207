class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :day

  validates :image, presence: { message: "を選択してください" }
  with_options presence: true do
    validates :name
    validates :text
    with_options numericality: { other_than: 1 , message: "を選択してください"} do
      validates :category_id
      validates :condition_id
      validates :postage_id
      validates :prefecture_id
      validates :day_id
    end
  end
  validates :price, presence: true
  validates :price, numericality: { only_integer: true, message: "は半角数字で入力してください" }, if: :is_not_half_width_number?
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は¥300〜9,999,999で入力してください" }, if: :is_half_width_number?

  def is_not_half_width_number?
    !(price_before_type_cast.match?(/\A[0-9]+\z/)) && price.present?
  end

  def is_half_width_number?
    price_before_type_cast.match?(/\A[0-9]+\z/)
  end
end