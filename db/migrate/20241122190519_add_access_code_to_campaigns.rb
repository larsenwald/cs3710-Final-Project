class AddAccessCodeToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :access_code, :string
    add_index :campaigns, :access_code, unique: true
  end
end
