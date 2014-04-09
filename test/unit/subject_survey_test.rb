# == Schema Information
#
# Table name: subject_surveys
#
#  id          :integer          not null, primary key
#  survey_id   :integer
#  subject_id  :integer
#  question_id :integer
#  answer_id   :integer
#  student_id  :integer
#  free_answer :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class SubjectSurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
