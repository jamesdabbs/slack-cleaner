class AddSlackDataToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :slack_id, :string, null: false
    add_column :users, :slack_data, :json

    add_index :users, :slack_id, unique: true
  end
end
