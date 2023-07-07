class Category < ApplicationRecord
  validates :zelty_id, presence: true
  validates :name, presence: true
  has_many :items
end
