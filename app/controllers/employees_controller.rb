class EmployeesController < ApplicationController
  def index
    if params[:tab] == "staff"
      @employees = Employee.includes(:employee_department).where(employee_departments: {department_name: 'Software Engineering'})
    elsif params[:tab] == "advisors"
      @employees = Employee.includes(:employee_department).where(employee_departments: {department_name: 'Student Advisor'})
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
    @employees = Employee.find(params[:employee_ids])
    @employees.each do |employee|
      User.create do |user|
        user.email = "employee#{employee.id}@swe.com"
        user.password = '12345678'
        user.password_confirmation = '12345678'
        user.user_type = 'employee'
        if employee.employee_position.position_title == 'Head of Department'
          user.role = 'Head of Department'
        elsif  employee.employee_position.position_title == 'Staff'
          user.role = 'Staff'
        elsif employee.employee_position.position_title == 'Advisor'
          user.role = 'Advisor'
        end
      end
      employee.update_attributes(user_id: User.last.id)
      
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
    @employee = Employee.find(params[:id])
  end
end
