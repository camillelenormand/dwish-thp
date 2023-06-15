class Order < ApplicationRecord
  validates :status, presence: true
  enum status: { pending: 0, paid: 1, cancelled: 2, refunded: 3}
  validates :amount, presence: true
  
  belongs_to :cart, presence: true
  belongs_to :user, presence: true
end
