<<<<<<< HEAD
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

=======
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
class Reply < ActiveRecord::Base
  attr_accessible :suggestion_id, :text, :user_id
  belongs_to :suggestion
  belongs_to :user
end
