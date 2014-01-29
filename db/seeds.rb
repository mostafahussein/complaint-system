# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Start Seeding Data to Database:'
puts '-' * 31

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Users'

User.create([{email: 'admin@swe.com', password: '12345678', password_confirmation: '12345678', user_type: 'admin'}])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Employee Departments'

EmployeeDepartment.create([{department_name: 'Software Engineering'},
	                       {department_name: 'Student Advisor'}
	                      ])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Employee Positions'

EmployeePosition.create([{position_title: 'Head Department'},
						 {position_title: 'Staff'},
						 {position_title: 'Advisor'}])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Employees'
#head of department
Staff.create([{full_name: 'Denny Kantner', gender: 'm', employee_department_id: 1, employee_position_id: 1}])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Statuses'
Status.create([
    {ticket_status: 'Open'},
    {ticket_status: 'In Progress'},
    {ticket_status: 'Pending'},
    {ticket_status: 'Solved'},
    {ticket_status: 'Closed'}
              ])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Priorities'
Priority.create([
    {priority_name: 'High',background: '#FEE7E7',color:'black'},
    {priority_name: 'Normal',background: '#FFFFF0',color: 'black'},
    {priority_name: 'Low',background: '#DDFFDD',color: 'black'}
                ])

#----------------------------------------------------------------------------------------------------------------------#
puts 'All Seeds Completed.'
