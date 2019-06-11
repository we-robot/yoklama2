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

require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
