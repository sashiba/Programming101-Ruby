class Brand < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  scope :search, lambda { |query| where(['name LIKE ?', "%#{query}%"])}
  scope :search_property, lambda { |property, query| where(["#{property} LIKE ?", "%#{query}%"]) }

  has_many :products, dependent: :destroy
end
