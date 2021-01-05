class Shift < ApplicationRecord
  validates :designated_on, presence: true
  validates :kind, presence: true
  belongs_to :user
end
