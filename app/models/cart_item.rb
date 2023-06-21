class CartItem < ApplicationRecord
  attr_accessor :name

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cart_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :item_id, presence: true

  belongs_to :cart
  belongs_to :item

  def total_price
    item.price * quantity
  end

  def item_name
    return item.name
  end

end
