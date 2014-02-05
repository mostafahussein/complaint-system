class SubjectsController < ApplicationController
  def index
    if params[:tab] == "all"
      @subjects = Subject.all
    elsif params[:tab] == "assigned"
      if current_user.advisor?
        @subjects = current_user.employee.subjects
        @total_complaints_sub = Subject.joins(advisor: {ticket_statuses: :ticket})
      end
    elsif params[:tab] == "enrolled"
      if current_user.student?
        @subjects = current_user.student.subjects
      end
    else
      render_404
    end
  end

  def show
    @subject = Subject.find(params[:id])

  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(params[:subject])
    if @subject.save
      redirect_to @subjects_path
    else
      redirect_to subjects_path
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      redirect_to subjects_path
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
    redirect_to subjects_path
  end

  def destroy
    @subject = Subject.find(params[:id])
  end
  
  def available_subjects
    if current_user.student?
      @subjects = current_user.student.subjects
    end
  end
end
