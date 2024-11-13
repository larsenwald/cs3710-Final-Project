class Campaign < ApplicationRecord
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_many :characters, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :setting, presence: true
  validates :active, inclusion: { in: [true, false] }
end
