class SubjectStaffsController < ApplicationController
  def new
    @subject_staff = SubjectStaff.new
    @subject_list = Subject.find_by_sql("SELECT subject_title FROM subjects WHERE subjects.id NOT IN (SELECT DISTINCT(subject_id) subject_id FROM subject_staffs)")
  end

  def create
    @subject_staff = SubjectStaff.new(params[:subject_staff])
    if @subject_staff.save
      flash[:success] = 'employees have been assigned'
      redirect_to @subjects_path
    else
      flash[:error] = 'something went error.'
      redirect_to subjects_path
    end
  end
end
