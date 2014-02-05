class StudentsController < ApplicationController
  def index
    @students = Student.where(user_id: nil)
  end

  def show
    @student = Student.find(params[:id])

  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      redirect_to students_path
    else
      redirect_to students_path
    end
  end

  def create_multiple
    if params[:student_ids].nil?
      flash[:error] = 'please select a student or more'
      redirect_to :back
    else
      @students = Student.find(params[:student_ids])
      @students.each do |student|
        User.create do |user|
          user.email = "student#{student.id}@swe.com"
          user.password = '12345678'
          user.password_confirmation = '12345678'
          user.user_type = "#{StudentsController::TYPEC}"
          user.role = "#{StudentsController::STUDENT}"
        end
        student.update_attributes(user_id: User.last.id)
      end
      redirect_to users_path(tab: 'all')
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = 'Profile updated'
      redirect_to students_path
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
  end
end
