class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :incidents, :severity
    add_index :incidents, :external_uuid, unique: true
    add_index :incidents, :day
    add_index :incidents, :hour_of_day
  end
end
