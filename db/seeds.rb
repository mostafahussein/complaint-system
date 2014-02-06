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

User.create([{email: 'admin@swe.com', password: '12345678', password_confirmation: '12345678', user_type: 'admin', role: 'admin'}])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Employee Departments'

EmployeeDepartment.create([{department_name: 'software engineering'},
{department_name: 'student advisor'}
])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Employee Positions'

EmployeePosition.create([{position_title: 'head of department'},
{position_title: 'staff'},
{position_title: 'advisor'}])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Employees'
#head of department
Staff.create([{full_name: 'Denny Kantner', gender: 'm', employee_department_id: 1, employee_position_id: 1}])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Statuses'
Status.create([
{ticket_status: 'open'},
{ticket_status: 'in progress'},
{ticket_status: 'pending'},
{ticket_status: 'solved'},
{ticket_status: 'closed'}])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Priorities'
Priority.create([
{priority_name: 'high',background: '#FEE7E7',color:'black'},
{priority_name: 'normal',background: '#FFFFF0',color: 'black'},
{priority_name: 'low',background: '#DDFFDD',color: 'black'}])
#----------------------------------------------------------------------------------------------------------------------#
puts 'Batches and Sections'
Batch.create([
{batch_name: 'Batch 1'},
{batch_name: 'Batch 2'},
{batch_name: 'Batch 3'},
{batch_name: 'Batch 4'}])

Section.create([
{section_name: 'Section 1', batch_id: 1},
{section_name: 'Section 2', batch_id: 1},
{section_name: 'Section 1', batch_id: 2},
{section_name: 'Section 2', batch_id: 2},
{section_name: 'Section 1', batch_id: 3},
{section_name: 'Section 2', batch_id: 3},
{section_name: 'Section 1', batch_id: 4},
{section_name: 'Section 2', batch_id: 4}])
puts 'All Seeds Completed.'
