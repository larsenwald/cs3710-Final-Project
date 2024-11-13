class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.integer :session_number
      t.datetime :date
      t.text :summary
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
