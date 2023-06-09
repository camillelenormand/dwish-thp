class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :status, presence: true
  
  belongs_to :cart ,index: { unique: true }, foreign_key: true
  belongs_to :user
end
