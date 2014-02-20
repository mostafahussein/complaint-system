module Modules
	module Statistics
		def grid_statistics(survey,subject,type,help_text)
  			s_question = Survey.find(survey)
  			questions = s_question.questions.where("questions.question_type = ?", "#{type}").each do |question|
  	 			@answers_list = []
      			answers = question.answers.each do |answer|
        			@answers_list << answer.content
  	 			end
    		end
    		@count_list = @answers_list.map { |answer| "COUNT(CASE a.content WHEN '#{answer}' THEN 1 END) AS \"#{answer}\"" }
      		question_state = self.find_by_sql("SELECT q.content  AS question_content , COUNT(*) AS total_responses,
      		#{@count_list.join(',')}
      		FROM subject_surveys AS sv
      		JOIN questions AS q ON  sv.question_id = q.id
      		JOIN answers AS a ON sv.answer_id = a.id
      		JOIN surveys AS s ON sv.survey_id = s.id
      		WHERE q.question_type = '#{type}' AND sv.survey_id = #{survey}
      		AND q.help_text = '#{help_text}' AND sv.subject_id = #{subject}
      		GROUP BY q.id, q.content
      		ORDER BY q.id")
    		puts question_state.as_json
  		end
	end
end