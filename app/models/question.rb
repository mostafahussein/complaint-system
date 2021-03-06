# == Schema Information
#
# Table name: questions
#
#  id                :integer          not null, primary key
#  survey_id         :integer
#  content           :string(255)
#  question_type     :string(255)
#  help_text         :string(255)
#  required_question :boolean          default(TRUE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Question < ActiveRecord::Base
	include Modules::DefaultValues
  attr_accessible  :content, :survey_id, :answers_attributes, :question_type, :help_text, :required_question
  belongs_to :survey
  has_many :answers
  accepts_nested_attributes_for :answers, allow_destroy: true
  has_many :subject_surveys
end
