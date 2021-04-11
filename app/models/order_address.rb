class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :order_id, :postal_code, :prefecture_id, :city, :block, :building, :phone, :token

  with_options presence: true do
    validates :token
    validates :postal_code
    validates :city
    validates :block
    validates :phone
    validates :user_id
    validates :item_id
  end
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は半角数字でハイフンを含み入力してください' }, allow_blank: true
  with_options allow_blank: true do
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' } do
      validates :city
      validates :block
    end
  end
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :phone, numericality: {
    only_integer: true, message: 'は半角数字で入力してください'
  }, if: :not_half_width_number?
  validates :phone, format: {
    with: /\A0[0-9]{10}\z/, message: 'は11桁で入力してください'
  }, if: :half_width_number?

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, block: block, building: building,
                   phone: phone, order_id: order.id)
  end

  private

  def not_half_width_number?
    !phone.match?(/\A[0-9]+\z/) && phone.present?
  end

  def half_width_number?
    phone.match?(/\A[0-9]+\z/)
  end
end
