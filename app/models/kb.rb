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

class Kb < ActiveRecord::Base
  attr_accessible :faq_question, :faq_answer, :subject_id
  belongs_to :subject
end
