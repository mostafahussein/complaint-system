class SubjectSurveysController < ApplicationController
	def index
		@sv_subs = SubjectSurvey.all
	end

	def show
		@sv_sub = SubjectSurvey.find(params[:id])
	end

	def new
		@sv_sub = SubjectSurvey.new
	end

	def create
		params[:subject_survey][:questions].each do |question, answer|
        	@sv_sub = SubjectSurvey.create(
            student_id: params[:subject_survey][:student_id],
            survey_id: params[:subject_survey][:survey_id],
            question_id: question,
            answer_id: answer)
    	end
		
		if @sv_sub.save
      		redirect_to surveys_path, notice: "Success."
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
end
