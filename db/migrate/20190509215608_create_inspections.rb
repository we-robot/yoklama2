class CreateInspections < ActiveRecord::Migration[5.2]
  def change
    create_table :inspections do |t|
      t.references :lesson, foreign_key: true

      t.timestamps
    end
  end
end
