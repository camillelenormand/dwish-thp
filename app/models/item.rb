class Item < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  #validates :image_url, presence: true   #commenté car bloque le chargement du seed.idem plus bas
  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  #validates :image_url, allow_blank: true, format: {
  # with: %r{\.(gif|jpg|png)\Z}i,
 # }


end
