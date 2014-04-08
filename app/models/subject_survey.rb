# == Schema Information
#
# Table name: subject_surveys
#
#  id          :integer          not null, primary key
#  survey_id   :integer
#  subject_id  :integer
#  question_id :integer
#  answer_id   :integer
#  student_id  :integer
#  free_answer :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SubjectSurvey < ActiveRecord::Base
  extend Modules::Statistics
  attr_accessible :subject_id , :survey_id, :student_id , :question_id, :answer_id,:free_answer
  belongs_to :subject
  belongs_to :student
  belongs_to :question
  belongs_to :answer




  # "SELECT q.content  AS Question, COUNT(*) AS total_responses,
  #   COUNT(CASE a.content WHEN 'required for major'        THEN 1 END) AS column1,
  #   COUNT(CASE a.content WHEN 'elective'        THEN 1 END) AS column2,
  #   COUNT(CASE a.content WHEN 'required for minor'        THEN 1 END) AS column3
  #   FROM subject_surveys AS sv
  #   JOIN questions AS q ON  sv.question_id = q.id
  #   JOIN answers AS a ON sv.answer_id = a.id
  #   JOIN surveys AS s ON sv.survey_id = s.id
  #   WHERE q.question_type = 'Choose From A List' AND sv.survey_id = 3
  #   GROUP BY q.id, q.content
  #   ORDER BY q.id"

end
