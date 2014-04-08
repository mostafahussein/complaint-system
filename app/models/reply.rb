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

class Reply < ActiveRecord::Base
  attr_accessible :suggestion_id, :text, :user_id
  belongs_to :suggestion
  belongs_to :user
end
