# == Schema Information
#
# Table name: responses
#
#  id              :integer          not null, primary key
#  canned_response :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
