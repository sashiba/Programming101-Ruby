class Task < ActiveRecord::Base
  belongs_to :lecture
  has_many :solutions, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
end
