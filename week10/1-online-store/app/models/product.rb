class Product < ActiveRecord::Base
  validates :name, presence: true
  # validates :brand, presence: true
  # validates :category, presence: true

  scope :search, lambda { |query| where(['name LIKE ?', "%#{query}%"])}
  scope :search_property, lambda { |property, query| where(["#{property} LIKE ?", "%#{query}%"]) }

  belongs_to :brand
  belongs_to :category
end
