class SubjectStaffsController < ApplicationController
  def new
    @subject_staff = SubjectStaff.new
    @subject_list = Subject.find_by_sql("SELECT id, subject_title FROM subjects WHERE subjects.id NOT IN (SELECT id FROM subject_staffs)")
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @subject_staff }
    end
  end

  def create
    @subject_staff = SubjectStaff.new(params[:subject_staff])
    if @subject_staff.save
      flash[:success] = 'employees have been assigned'
      redirect_to subjects_path(tab: 'assigned_subjects')
    else
      flash[:error] = 'something went error.'
      redirect_to subjects_path(tab: 'not_assigned_subjects')
    end
  end
  
  def edit
    @subject_staff = SubjectStaff.find(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.js # edit.js.erb
      format.json { render json: @subject_staff }
    end
  end

  def update
    @subject_staff = Subject.find(params[:id])
    if @subject_staff.update_attributes(params[:subject_staff])
      redirect_to subjects_path(tab: 'assigned_subjects')
    else
      render 'edit'
    end
  end
end
