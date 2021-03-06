class SubjectsController < ApplicationController
  before_filter :set_survey, only: :show
  #before_filter :set_chart, only: :show
  def index
    if params[:tab] == "all"
      @subjects = Subject.order(:id)
    elsif params[:tab] == 'assigned_subjects'
      @subjects = Subject.where("subjects.id in (select subject_staffs.id from subject_staffs)")
    elsif params[:tab] == 'not_assigned_subjects'
      @subjects = Subject.where("subjects.id not in (select subject_staffs.id from subject_staffs)")
    elsif params[:tab] == "assigned"
      if current_user.advisor?
        @subjects = current_user.employee.subjects
        @total_complaints_sub = Subject.joins(advisors: {ticket_statuses: :ticket})
      end
    elsif params[:tab] == "enrolled"
      if current_user.student?
        @subjects = current_user.student.subjects
      end
    elsif params[:tab] == "survey_results"
      if current_user.head_of_department?
        @subjects = Subject.order(:id)
      end
    else
      render_404
    end
  end

  def show
     is_report_available = @subject.subject_surveys
     if is_report_available.empty? || is_report_available.nil?
     
    else
      @subject = Subject.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.js # show.js.erb
        format.json { render json: @subject }
      end
    end
  end

  def new
    @subject = Subject.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @subject }
    end
  end

  def create
    @subject = Subject.new(params[:subject])
    if @subject.save
      redirect_to subjects_path(tab: 'not_assigned_subjects')
    else
      redirect_to :back
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.js # edit.js.erb
      format.json { render json: @subject }
    end
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      redirect_to :back
    else
      render 'edit'
    end
  end

  def assign_advisors
    if params[:subject_ids].nil?
      flash[:error] = 'please select a subject or more'
      redirect_to :back
    else
      @subjects = Subject.find(params[:subject_ids])
    end
  end

  def update_multiple
    @subjects = Subject.find(params[:subject_ids])
    @subjects.each do |subject|
      subject.update_attributes(params[:subject])
    end
    redirect_to :back
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    respond_to do |format|
        format.html
        format.js # destroy.js.erb
        format.json { head :no_content }
      end
  end
  
  def available_subjects
    if current_user.student?
      @subjects = current_user.student.subjects
    end
  end

  def set_survey
    @subject = Subject.find(params[:id])
    survey_id = @subject.survey_id
    @survey = Survey.find(survey_id)
    @questions = @survey.questions.where("questions.question_type != ?", "#{Question::GRID}").order("questions.id asc")
    @questions_grid = @survey.questions.where("questions.help_text != ? AND questions.question_type = ?", '', "#{Question::GRID}").order("questions.id asc").group_by { |q| q.help_text }
  end

  def set_chart
    @subject = Subject.find(params[:id])
    survey_id = @subject.survey_id
    @survey = Survey.find(survey_id)
    @questions = @survey.questions.where("questions.question_type != ?", "#{Question::GRID}").order("questions.id asc")
    @questions.each do |question|
      @chart = SubjectSurvey.chart_statistics(survey_id,@subject.id,question.question_type,question.id).as_json.first.collect {|k,v| [k.humanize.capitalize,v.to_i]}
      return @chart
    end
  end
end
