class Cart < ApplicationRecord
  validates :user_id, presence: true
  enum status: { in_progress: 0, paid: 1, cancelled: 2, expired: 3 }
  validates :status, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :cart_items, foreign_key: 'cart_id', class_name: 'CartItem', dependent: :destroy
  has_many :items, through: :cart_items, source: :item
  
  has_many :cart_items, dependent: :destroy
  belongs_to :user
  belongs_to :order, optional: true

  def cart_items_number
    self.cart_items.count
  end 

  def cart_items_array
    self.cart_items
  end

# Hash containing grouped  by item {1=>8, 2=>1, 4=>1} 
  def cart_hash
    self.cart_items.group(:item_id).count
    pp self.cart_items.group(:item_id).count
  end

  def find_cart_items_price(id)
    self.cart_items.find_by(item_id: id).price
    pp self.cart_items.find_by(item_id: id).price
  end

  def total_amount
    cart_items.to_a.sum { |item| item.total_price }
  end

end
