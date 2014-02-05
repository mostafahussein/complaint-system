class Questionnaire < ActiveRecord::Base
  include Modules::DefaultValues
  attr_accessible :subject_id, :survey_id, :student_id, :question_id, :answer_id, :describtion, :comment
  belongs_to :subject
  belongs_to :student
  belongs_to :survey
  belongs_to :answer
  belongs_to :question
end
