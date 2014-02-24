module Modules
	module Statistics

    def fetch_data(survey,type,q_id)
      s_question = Survey.find(survey)
      questions = s_question.questions.where("questions.question_type = ? AND questions.id = ?", "#{type}", "#{q_id}").each do |question|
        @answers_list = question.answers.collect { |answer| answer.content }
      end
      @count_list = @answers_list.each_with_index.map { |answer, index| 
        "COUNT(CASE a.content WHEN '#{answer}' THEN 1 END) AS \"answer_#{index+1}\"" }
      @count_columns = @answers_list.map { |answer| 
        "COUNT(CASE a.content WHEN '#{answer}' THEN 1 END) AS \"#{answer.squish.downcase.tr(" ","_")}\"" }
    end
    
		def question_statistics(survey,subject,type,q_id=nil,help_text=nil)
      fetch_data(survey,type,q_id)
      from_table = "FROM subject_surveys AS sv
        JOIN questions AS q ON  sv.question_id = q.id
        JOIN answers AS a ON sv.answer_id = a.id
        JOIN surveys AS s ON sv.survey_id = s.id"
      group = "GROUP BY q.content, q.id ORDER BY q.id"

      if type == "#{Question::GRID}"
        question_state = self.find_by_sql("SELECT q.content  AS question_content , COUNT(*) AS total_responses,
        #{@count_list.join(',')}
        #{from_table}
        WHERE q.question_type = '#{type}' AND sv.survey_id = #{survey}
        AND q.help_text = '#{help_text}' AND sv.subject_id = #{subject}
        #{group}")
      elsif type == "#{Question::RADIO}" || type == "#{Question::LIST}"

        question_state = self.find_by_sql("SELECT a.content AS answer_content ,
        COUNT(*) AS count
        #{from_table}
        WHERE q.question_type = '#{type}' AND sv.survey_id = #{survey}
        AND sv.subject_id = #{subject} AND q.id = #{q_id}
        GROUP BY q.id, q.content, a.id ORDER BY q.id, a.id")
      end
      return question_state
  	end

    def total_responses(survey,subject,type,q_id)
      if type == "#{Question::RADIO}" || type == "#{Question::LIST}"

        total = self.find_by_sql("SELECT COUNT(*) AS total_responses
        FROM subject_surveys AS sv
        JOIN questions AS q ON sv.question_id = q.id
        WHERE q.question_type = '#{type}' AND sv.survey_id = #{survey}
        AND sv.subject_id = #{subject} AND q.id = #{q_id}
        GROUP BY q.id, q.content ORDER BY q.id")

      end
      return total
    end

    def chart_statistics(survey,subject,type,q_id)
      fetch_data(survey,type,q_id)
      from_table = "FROM subject_surveys AS sv
        JOIN questions AS q ON  sv.question_id = q.id
        JOIN answers AS a ON sv.answer_id = a.id
        JOIN surveys AS s ON sv.survey_id = s.id"
      group = "GROUP BY q.content, q.id ORDER BY q.id"

      if type == "#{Question::RADIO}" || type == "#{Question::LIST}"

        question_chart = self.find_by_sql("SELECT #{@count_columns.join(',')}
        #{from_table}
        WHERE q.question_type = '#{type}' AND sv.survey_id = #{survey}
        AND sv.subject_id = #{subject} AND q.id = #{q_id}
        GROUP BY q.id ORDER BY q.id")
      end
      return question_chart
    end

	end
end