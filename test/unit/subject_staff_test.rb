# == Schema Information
#
# Table name: subject_staffs
#
#  id         :integer          not null, primary key
#  staff_id   :integer
#  advisor_id :integer
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SubjectStaffTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
