class Solution < ActiveRecord::Base
  belongs_to :task
  validates :text_block, presence: true
end

