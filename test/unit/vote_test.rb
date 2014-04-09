# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  suggestion_id :integer
#  user_id       :integer
#  vote          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
