class AddRateToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :rate, :float
  end
end
