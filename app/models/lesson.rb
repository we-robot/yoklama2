# == Schema Information
#
# Table name: lessons
#
#  id             :bigint           not null, primary key
#  adi            :string
#  ders_kodu      :string
#  sinif          :integer
#  teorik_saat    :integer
#  uygulama_saati :integer
#  akts           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Lesson < ApplicationRecord
  has_and_belongs_to_many :students
  has_many :inspections


  def to_label
    self.adi
  end
end
