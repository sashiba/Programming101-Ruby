class Lecture < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :text_body, presence: true
end

