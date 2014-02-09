class SubjectSurvey < ActiveRecord::Base
  attr_accessible :subject_id , :survey_id
  belongs_to :survey
  belongs_to :subject
end
