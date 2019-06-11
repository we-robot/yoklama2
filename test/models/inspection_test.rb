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

require 'test_helper'

class InspectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
