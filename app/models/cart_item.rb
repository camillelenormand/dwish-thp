class CartItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cart, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :cart
  belongs_to :item
end
