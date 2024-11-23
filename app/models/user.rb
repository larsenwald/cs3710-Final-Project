class User < ApplicationRecord
  has_many :campaign_memberships, dependent: :destroy
  has_many :joined_campaigns, through: :campaign_memberships, source: :campaign

  # Constants
  ROLES = %w[DM Player].freeze

  public
  def inspect # Using a homemade inspect method because Devise's is fucking shit and gives me errors when I try to get a summary of User attributes
    "#<User id: #{id}, username: #{username}, email: #{email}, user_role: #{user_role}>"
  end



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :campaigns, dependent: :destroy
  has_many :characters, dependent: :destroy

  before_validation :set_default_role, on: :create

  validates :username, presence: true,
                      uniqueness: true,
                      length: { maximum: 30 }

  validates :email, presence: true,
                   uniqueness: true,
                   format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :user_role, presence: true,
                       inclusion: { in: ROLES }

  def dm?
    user_role == ROLES[0]
  end

  def player?
    user_role == ROLES[1]
  end

  private
  def set_default_role
    self.user_role ||= ROLES[1] # Defaults to "Player"
  end
end
