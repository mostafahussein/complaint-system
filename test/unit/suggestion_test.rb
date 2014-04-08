# == Schema Information
#
# Table name: suggestions
#
#  id               :integer          not null, primary key
#  student_id       :integer
#  subject_id       :integer
#  subject_field_id :integer
#  content          :string(255)
#  title            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class SuggestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
