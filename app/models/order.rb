class Order < ApplicationRecord
  validates :status, presence: true
  enum status: { paid: 0, cancelled: 1, refunded: 2}
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  
  belongs_to :cart, foreign_key: true
  belongs_to :user, foreign_key: true
  
  validate :cart_and_user_present
  
  private
  
  def cart_and_user_present
    if cart.nil? || user.nil?
      errors.add(:base, "Cart and User must be present")
    end
  end
end
