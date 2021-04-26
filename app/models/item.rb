class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order
  has_many :comments
  has_many_attached :images
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :day

  validates :images, presence: { message: 'を選択してください' }
  with_options presence: true do
    validates :name
    validates :text
    validates :price
    with_options numericality: { other_than: 1, message: 'を選択してください' } do
      validates :category_id
      validates :condition_id
      validates :postage_id
      validates :prefecture_id
      validates :day_id
    end
  end
  validates :price, numericality: {
    only_integer: true, message: 'は半角数字で入力してください'
  }, if: :not_half_width_number?
  validates :price, numericality: {
    greater_than_or_equal_to: 300, message: 'は¥300以上で入力してください'
  }, if: :half_width_number?
  validates :price, numericality: {
    less_than_or_equal_to: 9_999_999, message: 'は¥9,999,999以下で入力してください'
  }, if: :half_width_number?

  def self.search(search)
    if search != ''
      Item.where('name or text LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

  private

  def not_half_width_number?
    !price_before_type_cast.to_s.match?(/\A[0-9]+\z/) && price.present?
  end

  def half_width_number?
    price_before_type_cast.to_s.match?(/\A[0-9]+\z/)
  end
end
