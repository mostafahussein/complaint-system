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
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      flash[:notice] = 'A new employee created successfully.'
      if (@employee.employee_position.position_title == "#{EmployeesController::SWE_MANAGER}") || (@employee.employee_position.position_title == "#{EmployeesController::SWE_STAFF}")
        department = EmployeeDepartment.where(department_name: "#{EmployeesController::SWE}").first
        @employee.update_attributes(employee_department_id: department.id)
        redirect_to employees_path(tab: 'staff_not_users')
      elsif @employee.employee_position.position_title == "#{EmployeesController::STAD_ADVISOR}"
        department = EmployeeDepartment.where(department_name: "#{EmployeesController::STAD}").first
        @employee.update_attributes(employee_department_id: department.id)
        redirect_to employees_path(tab: 'advisors_not_users')
      end
    else
      flash[:error] = 'An error occurred please try again!'
      redirect_to employees_path(tab: "staff")
    end
  end

  def create_multiple
    if params[:employee_ids].nil?
      flash[:error] = 'please select an employee or more'
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
          else
            flash[:error] = "employee#{employee.id}@swe.com already exists"
          end
        end
      end
      redirect_to users_path(tab: 'all')
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      flash[:notice] = 'Profile updated'
      redirect_to employees_path(filter: "staff")
    else
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id]).destroy
    flash[:success] = "Employee deleted."
    redirect_to :back
  end
end
