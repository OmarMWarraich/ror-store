class Product < ApplicationRecord
  has_one_attached :featured_image
  has_rich_text :description

  belongs_to :user
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :inventory_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
