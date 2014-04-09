# == Schema Information
#
# Table name: kbs
#
#  id           :integer          not null, primary key
#  faq_question :string(255)
#  faq_answer   :string(255)
#  subject_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class KbTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
