class Cart < ApplicationRecord
  validates :user_id, presence: true
  enum status: { in_progress: 0, validated: 1, paid: 2, cancelled: 3, trashed: 4 }
  
  has_many :cart_items, dependent: :destroy
  belongs_to :user

end
