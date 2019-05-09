class Lesson < ApplicationRecord
  has_and_belongs_to_many :students
  has_many :inspections


  def to_label
    self.adi
  end
end
