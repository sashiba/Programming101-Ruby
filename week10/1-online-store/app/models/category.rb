class Category < ActiveRecord::Base
  validates :name, presence: true

  scope :search, lambda { |query| where(['name LIKE ?', "%#{query}%"])}
  scope :search_property, lambda { |property, query| where(["#{property} LIKE ?", "%#{query}%"]) }

  has_many :products
end
