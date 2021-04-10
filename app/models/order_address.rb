class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :order_id, :postal_code, :prefecture_id, :city, :block, :building, :phone

  with_options presence: true do
    validates :postal_code
    validates :city
    validates :block
    validates :phone
    validates :user_id
    validates :item_id
  end
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は半角数字でハイフンを含み入力してください' }, allow_blank: true
  validates :city, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }, allow_blank: true
  validates :block, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }, allow_blank: true
  validates :phone, format: { with: /\A[0-9]{10..11}\z/, message: 'は半角数字で入力してください' }, allow_blank: true
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, block: block, building: building,
                   phone: phone, order_id: order.id)
  end
end
