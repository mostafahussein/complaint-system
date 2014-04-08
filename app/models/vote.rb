<<<<<<< HEAD
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

=======
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
class Vote < ActiveRecord::Base
  attr_accessible :suggestion_id, :user_id, :vote
  belongs_to :suggestion
  belongs_to :user
end
