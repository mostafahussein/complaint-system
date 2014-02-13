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
		@sv_sub.save
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
