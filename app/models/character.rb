class Character < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  validates :name, presence: true, length: { maximum: 50 }
  validates :character_class, presence: true
  validates :level, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :backstory, length: { maximum: 500 }
end
