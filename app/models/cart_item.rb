class CartItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cart, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :cart
  belongs_to :item

  def find_item_name
    item_name=(Item.find_by_id (self.item_id)).name
  end 

  def display_price(id)
    Item.find_by_id(id.to_i).name
    pp Item.find_by_id(id.to_i).name
   end 

end
