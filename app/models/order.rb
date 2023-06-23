class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :status, presence: true
  enum status: { draft: 0, paid: 1, cancelled: 2, refunded: 3 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
      
end
