class Inspection < ApplicationRecord
  belongs_to :lesson

  attr_accessor :teorik_saat, :uygulama_saati
  enum lesson_type: [ :uygulama, :teorik ]

end
