class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :status, presence: true
  enum status: { in_progress: 0, validated: 1, paid: 2, cancelled: 3, trashed: 4, refunded: 5 }
  validates :amount, presence: true
  
  belongs_to :cart, foreign_key: true
  belongs_to :user
end
