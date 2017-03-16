class CreateIncidents < ActiveRecord::Migration[5.0]
  def change
    create_table :incidents do |t|
      t.text :description
      t.string :severity
      t.string :external_uuid
      t.string :light
      t.string :weather
      t.string :traffic
      t.datetime :occurred_from
      t.datetime :occurred_to
      t.string :hour_of_day
      t.string :day
      t.column :lat, :decimal, :precision => 15, :scale => 10
      t.column :lng, :decimal, :precision => 15, :scale => 10
      t.timestamps
    end
  end
end
