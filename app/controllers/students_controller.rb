class StudentsController < ApplicationController
  def index
    if params[:tab] == "all_students"
      @students = Student.all
    elsif params[:tab] == "not_users"
      @students = Student.where(user_id: nil)
    end
  end

  def show
    @student = Student.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.js # show.js.erb
      format.json { render json: @student }
    end
  end

  def new
    @student = Student.new
    @batches = Batch.order(:id)
    @sections = []
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @student }
    end
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      redirect_to students_path(tab: 'not_users')
    else
      redirect_to :back
    end
  end

  def available_sections
    batch_id =  (params[:batch_id].nil? || params[:batch_id].empty?) ? 0 : params[:batch_id].to_i

    if batch_id == 0
      @sections = [].insert(0, "Select Section")
    else
      batch = Batch.find(params[:batch_id])
      # map to name and id for use in our options_for_select
      @sections = batch.sections.map{|a| [a.section_name, a.id]}
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
    respond_to do |format|
      format.html # edit.html.erb
      format.js # edit.js.erb
      format.json { render json: @student }
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = 'Profile updated'
      redirect_to :back
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    respond_to do |format|
      format.html
        format.js # destroy.js.erb
        format.json { head :no_content }
      end
    end
  end
