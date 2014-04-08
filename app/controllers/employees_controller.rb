class EmployeesController < ApplicationController
  def index
    if params[:tab] == 'all_staff'
      @employees = Employee.joins(:employee_department).where(employee_departments: {department_name: "#{EmployeesController::SWE}"})
    elsif params[:tab] == "all_advisors"
      @employees = Employee.joins(:employee_department).where(employee_departments: {department_name: "#{EmployeesController::STAD}"})
    elsif params[:tab] == "staff_not_users"
      @employees = Employee.joins(:employee_department).where(employee_departments: {department_name: "#{EmployeesController::SWE}"}, employees: {user_id: nil})
    elsif params[:tab] == "advisors_not_users"
      @employees = Employee.joins(:employee_department).where(employee_departments: {department_name: "#{EmployeesController::STAD}"}, employees: {user_id: nil})
    else
      render_404
    end
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
    @departments = EmployeeDepartment.all
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.json { render json: @employee }
    end
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      flash[:notice] = 'A new employee created successfully.'
      if (@employee.employee_position.position_title == "#{EmployeesController::SWE_MANAGER}")
        department = EmployeeDepartment.where(department_name: "#{EmployeesController::SWE}").first
        @employee.update_attributes(employee_department_id: department.id, type: 'Staff')
        redirect_to employees_path(tab: 'staff_not_users')
      elsif  (@employee.employee_position.position_title == "#{EmployeesController::SWE_STAFF}")
        department = EmployeeDepartment.where(department_name: "#{EmployeesController::SWE}").first
        @employee.update_attributes(employee_department_id: department.id, type: 'Staff')
        redirect_to employees_path(tab: 'staff_not_users')
      elsif @employee.employee_position.position_title == "#{EmployeesController::STAD_ADVISOR}"
        department = EmployeeDepartment.where(department_name: "#{EmployeesController::STAD}").first
        @employee.update_attributes(employee_department_id: department.id, type: 'Advisor')
        redirect_to employees_path(tab: 'advisors_not_users')
      end
    else
      flash[:error] = 'An error occurred please try again!'
<<<<<<< HEAD
      redirect_to employees_path(tab: "all_staff")
=======
      redirect_to employees_path(tab: "staff")
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
    end
  end

  def create_multiple
    if params[:employee_ids].nil?
      flash[:error] = 'Please select an employee or more'
      redirect_to :back
    else
      @employees = Employee.find(params[:employee_ids])
      @employees.each do |employee|
        User.create do |user|
          if User.where(email: "employee#{employee.id}@swe.com").exists? == false
            user.email = "employee#{employee.id}@swe.com"
            user.password = '12345678'
            user.password_confirmation = '12345678'
            user.user_type = 'employee'
            if employee.employee_position.position_title == "#{EmployeesController::SWE_MANAGER}"
              user.role = "#{EmployeesController::MANAGER}"
            elsif  employee.employee_position.position_title == "#{EmployeesController::SWE_STAFF}"
              user.role = "#{EmployeesController::STAFF}"
            elsif employee.employee_position.position_title == "#{EmployeesController::STAD_ADVISOR}"
              user.role = "#{EmployeesController::ADVISOR}"
            end
            employee.update_attributes(user_id: User.last.id)
            redirect_to users_path(tab: 'all')
            flash[:notice] = 'user created successfully'
          else
            flash[:error] = "employee#{employee.id}@swe.com already exists"
            redirect_to :back
          end
        end
      end
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.js # edit.js.erb
      format.json { render json: @employee }
    end
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      flash[:notice] = 'Details updated'
      redirect_to :back
    else
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id]).destroy
    respond_to do |format|
      format.html
        format.js # destroy.js.erb
        format.json { head :no_content }
      end
    end
  end
