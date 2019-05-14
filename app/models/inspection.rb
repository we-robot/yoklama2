class Inspection < ApplicationRecord
  attr_accessor :teorik_saat, :uygulama_saati
  enum lesson_type: [ :uygulama, :teorik ]

  belongs_to :lesson
  has_and_belongs_to_many :students

  has_one_attached :image
end
