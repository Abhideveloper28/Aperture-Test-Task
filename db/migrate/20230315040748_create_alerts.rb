class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.string :alert_type
      t.string :description
      t.string :tags, array: true
      t.string :origin

      t.timestamps
    end
  end
end
