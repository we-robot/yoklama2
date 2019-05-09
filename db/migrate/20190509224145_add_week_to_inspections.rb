class AddWeekToInspections < ActiveRecord::Migration[5.2]
  def change
    add_column :inspections, :week, :integer
    add_column :inspections, :hour, :integer
  end
end
