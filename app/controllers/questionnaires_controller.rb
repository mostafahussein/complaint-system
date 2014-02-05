class QuestionnairesController < ApplicationController
  before_filter :set_subject, only: [:new, :create]
  def new
    @questionnaire = Questionnaire.new
  end
  private
  def set_subject
    @title = Subject.find(params[:subject_id]).subject_title
    @subject = Subject.find(params[:subject_id]).id
  end
end
