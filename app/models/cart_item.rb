class CartItem < ApplicationRecord
  attr_accessor :name

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cart_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :item_id, presence: true

  belongs_to :cart
  belongs_to :item

  def find_item_name
    item_name=(Item.find_by_id (self.item_id)).name
  end 

  def display_price(id)
    Item.find_by_id(id.to_i).name
    pp Item.find_by_id(id.to_i).name
  end 

  def total_price
    item.price.to_i * quantity.to_i
  end

end
