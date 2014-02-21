module Modules
	module Statistics

    def fetch_data(survey,type)
      s_question = Survey.find(survey)
      questions = s_question.questions.where("questions.question_type = ?", "#{type}").each do |question|
        @answers_list = question.answers.collect { |answer| answer.content }
      end
      @count_list = @answers_list.each_with_index.map { |answer, index| "COUNT(CASE a.content WHEN '#{answer}' THEN 1 END) AS \"answer_#{index+1}\"" }
    end
    
		def question_statistics(survey,subject,type,help_text=nil)
      fetch_data(survey,type)
      from_table = "FROM subject_surveys AS sv
        JOIN questions AS q ON  sv.question_id = q.id
        JOIN answers AS a ON sv.answer_id = a.id
        JOIN surveys AS s ON sv.survey_id = s.id"
      group = "GROUP BY q.id, q.content, a.id ORDER BY q.id, a.id"

      if type == "#{Question::GRID}"
        question_state = self.find_by_sql("SELECT q.content  AS question_content , COUNT(*) AS total_responses,
        #{@count_list.join(',')}
        #{from_table}
        WHERE q.question_type = '#{type}' AND sv.survey_id = #{survey}
        AND q.help_text = '#{help_text}' AND sv.subject_id = #{subject}
        #{group}")
      elsif type == "#{Question::RADIO}" || type == "#{Question::LIST}"
        question_state = self.find_by_sql("SELECT q.content  AS question_content , COUNT(*) AS total_responses,
        #{@count_list.join(',')}
        #{from_table}
        WHERE q.question_type = '#{type}' AND sv.survey_id = #{survey}
        AND sv.subject_id = #{subject}
        #{group}")
      end
      @state_table = question_state
      @state_chart = question_state.as_json
      puts question_state.as_json
  	end    
	end
end