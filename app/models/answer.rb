# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer
#  content     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  attr_accessible :content, :question_id
  belongs_to :question
  has_many :subject_surveys

  def answer_for_select
  content.capitalize
end
end
