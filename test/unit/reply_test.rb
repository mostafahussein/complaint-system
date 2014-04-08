# == Schema Information
#
# Table name: replies
#
#  id            :integer          not null, primary key
#  text          :string(255)
#  suggestion_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
