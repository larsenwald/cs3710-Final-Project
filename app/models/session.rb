class Session < ApplicationRecord
  belongs_to :campaign

  validates :date, presence: true
  validates :summary, presence: true
  validates :session_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
