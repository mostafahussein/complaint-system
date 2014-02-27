class SubjectSurveysController < ApplicationController
	before_filter :set_subject, only: [:new, :create]
  	before_filter :set_user, only: [:new, :create]
  	before_filter :set_survey, only: [:new, :create]
	def index
		@sv_subs = SubjectSurvey.all
	end

	def show
		@sv_sub = SubjectSurvey.find(params[:id])
	end

	def new
		@sv_sub = SubjectSurvey.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @sv_sub }
    end
	end

	def create
		params[:subject_survey][:questions].each do |question, answer|
        	@sv_sub = SubjectSurvey.create(
            student_id: params[:subject_survey][:student_id],
            subject_id: params[:subject_survey][:subject_id],
            survey_id: params[:subject_survey][:survey_id],
            question_id: question,
            answer_id: answer)
    	end
		
		if @sv_sub.save
      		redirect_to :back, notice: "Success."
    	else
      		render :new, notice: "Failed."
    	end
	end

	def edit
		@sv_sub = SubjectSurvey.find(params[:id])
	end

	def update
		@sv_sub = SubjectSurvey.find(params[:id])
		@sv_sub.update_attributes(params[:subject_survey])
	end

	def destroy
		@sv_sub = SubjectSurvey.find(params[:id])
		@sv_sub.destroy
	end

	private
  	
  	def set_subject
    	@subject = Subject.find(params[:subject_id])
  	end

  	def set_survey
  		survey_id = Subject.find(params[:subject_id]).survey_id
  		@survey = Survey.find(survey_id)
  		@questions = @survey.questions.where("questions.question_type != ? AND questions.question_type != ? AND questions.question_type != ?", "#{Question::GRID}", "#{Question::BOX}", "#{Question::AREA}").order("questions.id asc")
  		@questions_grid = @survey.questions.where("questions.help_text != ? AND questions.question_type = ?", '', "#{Question::GRID}").order("questions.id asc").group_by { |q| q.help_text }
      @questions_free = @survey.questions.where("questions.question_type = ? OR questions.question_type = ?","#{Question::BOX}","#{Question::AREA}").order("questions.id asc")
  	end

  def set_user
    if current_user.student
      @student = current_user.student.id
    end
  end
end
