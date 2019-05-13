class CreateJoinTableStudentsInspections < ActiveRecord::Migration[5.2]
  def change
    create_join_table :students, :inspections do |t|
      # t.index [:student_id, :inspection_id]
      # t.index [:inspection_id, :student_id]
    end
  end
end
