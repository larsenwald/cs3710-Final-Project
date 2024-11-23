class CampaignMembership < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  validates :user_id, uniqueness: { scope: :campaign_id, message: "is already a member of this campaign." }
end
