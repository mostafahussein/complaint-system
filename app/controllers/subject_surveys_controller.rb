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
		@sv_sub = SubjectSurvey.new(params[:subject_survey])
	end

	def edit
		@sv_sub = SubjectSurvey.find(params[:id])
	end

	def update
		
	end

	def destroy
		
	end
end
