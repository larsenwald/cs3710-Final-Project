class Campaign < ApplicationRecord
  belongs_to :user
  has_many :sessions, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :campaign_memberships, dependent: :destroy
  has_many :players, through: :campaign_memberships, source: :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :setting, presence: true
  validates :active, inclusion: { in: [ true, false ] }
  validates :access_code, uniqueness: true

  before_create :generate_access_code

  private

  def generate_access_code
    self.access_code = loop do
      code = SecureRandom.hex(4).upcase # Generates an 8-character unique code
      break code unless Campaign.exists?(access_code: code)
    end
  end
end
