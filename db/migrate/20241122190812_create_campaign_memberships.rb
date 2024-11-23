class CreateCampaignMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :campaign_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
