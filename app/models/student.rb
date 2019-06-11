# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  name       :string
#  surname    :string
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rate       :float
#

class Student < ApplicationRecord
  has_and_belongs_to_many :lessons
  has_and_belongs_to_many :inspections
end
