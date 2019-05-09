class CreateJoinTableStudentsLessons < ActiveRecord::Migration[5.2]
  def change
    create_join_table :lessons, :students do |t|
      # t.index [:lesson_id, :student_id]
      # t.index [:student_id, :lesson_id]
    end
  end
end
