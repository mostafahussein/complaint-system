# ## Schema Information
#
# Table name: `subject_surveys`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`survey_id`**    | `integer`          |
# **`subject_id`**   | `integer`          |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
# **`question_id`**  | `integer`          |
# **`answer_id`**    | `integer`          |
# **`student_id`**   | `integer`          |
#

class SubjectSurvey < ActiveRecord::Base
  attr_accessible :subject_id , :survey_id, :student_id , :question_id, :answer_id
  belongs_to :subject
  belongs_to :student
  belongs_to :question
  belongs_to :answer


  def self.statistics(survey,type,help_text)
  	s_question = Survey.find(survey)
  	questions = s_question.questions.where("questions.question_type = ?", "#{type}").each do |question|
  	 @answers_list = []
      answers = question.answers.each do |answer|
        @answers_list << answer.content
  	 end
    end
    if @answers_list.size.equal? 5
      question_state = self.find_by_sql("SELECT
      q.content  AS question_content , COUNT(*) AS total_responses,
      COUNT(CASE a.content WHEN '#{@answers_list[0]}' THEN 1 END) AS \"#{@answers_list[0]}\",
      COUNT(CASE a.content WHEN '#{@answers_list[1]}' THEN 1 END) AS \"#{@answers_list[1]}\",
      COUNT(CASE a.content WHEN '#{@answers_list[2]}' THEN 1 END) AS \"#{@answers_list[2]}\",
      COUNT(CASE a.content WHEN '#{@answers_list[3]}' THEN 1 END) AS \"#{@answers_list[3]}\",
      COUNT(CASE a.content WHEN '#{@answers_list[4]}' THEN 1 END) AS \"#{@answers_list[4]}\"
      FROM subject_surveys AS sv
      JOIN questions AS q ON  sv.question_id = q.id
      JOIN answers AS a ON sv.answer_id = a.id
      JOIN surveys AS s ON sv.survey_id = s.id
      WHERE q.question_type = '#{type}' AND sv.survey_id = #{survey}
      AND q.help_text = '#{help_text}'
      AND a.content IN ('#{@answers_list[0]}', '#{@answers_list[1]}', '#{@answers_list[2]}', '#{@answers_list[3]}', '#{@answers_list[4]}')
      GROUP BY q.id, q.content
      ORDER BY q.id")
      puts question_state.as_json
    end
  end

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
