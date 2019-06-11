# == Schema Information
#
# Table name: inspections
#
#  id          :bigint           not null, primary key
#  lesson_id   :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  week        :integer
#  hour        :integer
#  lesson_type :integer
#

class Inspection < ApplicationRecord
  attr_accessor :teorik_saat, :uygulama_saati
  enum lesson_type: [ :uygulama, :teorik ]

  belongs_to :lesson
  has_and_belongs_to_many :students

  has_one_attached :image
end
