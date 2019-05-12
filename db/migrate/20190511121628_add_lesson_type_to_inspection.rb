class AddLessonTypeToInspection < ActiveRecord::Migration[5.2]
  def change
    add_column :inspections, :lesson_type, :integer
  end
end
