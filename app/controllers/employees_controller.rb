class EmployeesController < ApplicationController
  def index
    if params[:tab] == "staff"
      @employees = Employee.includes(:employee_department).where(employee_departments: {department_name: "#{EmployeesController::SWE}"})
    elsif params[:tab] == "advisors"
      @employees = Employee.includes(:employee_department).where(employee_departments: {department_name: "#{EmployeesController::STAD}"})
    else
      render_404
    end
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      flash[:notice] = 'A new user created successfully.'
      redirect_to @employee
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
          elsif employee.employee_position.position_title == "#{EmployeeController::STAD_ADVISOR}"
            user.role = "#{EmployeesController::ADVISOR}"
          end
          employee.update_attributes(user_id: User.last.id)
        else
          flash[:error] = "employee#{employee.id}@swe.com already exists"
        end
      end
    end
    redirect_to users_path
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
