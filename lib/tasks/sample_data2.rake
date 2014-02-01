namespace :db do
  desc 'Fill database with sample data'
  task update_sample: :environment do
    Faker::Config.locale = :en
    make_employees_and_students_as_users
    attended_subjects
    assign_advisors_to_subjects
    make_complaints
  end
end

def make_employees_and_students_as_users
  puts "Making Employees and Students as Users"
  employees = Employee.all(limit: 300)
  employees.each do |employee|
    User.create! do |user|
      user.email = "employee#{employee.id}@swe.com"
      user.password = '12345678'
      user.password_confirmation = '12345678'
      user.user_type = 'employee'
      if (employee.employee_department.department_name == "Software Engineering" && employee.employee_position.position_title == "Head Department")
        user.role = 'Head of Department'
      elsif (employee.employee_department.department_name == "Software Engineering" && employee.employee_position.position_title == "Staff")
        user.role = "Staff"
      elsif (employee.employee_department.department_name == "Student Advisor" && employee.employee_position.position_title == "Advisor")
        user.role = "Advisor"
      end
    end
    user_id = User.last.id
    employee.update_attributes(user_id: user_id)
  end

  students = Student.all(limit: 200)
  students.each do |student|
    User.create! do |user|
      user.email = "student#{student.id}@swe.com"
      user.password = '12345678'
      user.password_confirmation = '12345678'
      user.user_type = 'student'
      user.role = "Student"
    end
    user_id = User.last.id
    student.update_attributes(user_id: user_id)
  end
end

def attended_subjects
  puts "Attended Subjects"
  students = Student.all(limit: 200)
  subjects = Subject.all(limit: 5)
  students.each do |student|
    subjects.each do |subject|
      if Attend.where(student_id: student.id, subject_id: subject.id).exists? == false
        Attend.create!([{student_id: student.id, subject_id: subject.id}])
      end
    end
  end
end

def assign_advisors_to_subjects
  puts "Assign Advisors to Subjects"
  10.times do
    advisor = Advisor.first(order: "RANDOM()")
    subjects = Subject.all(limit: 2, order: "RANDOM()")
    subjects.each do |subject|
      if subject.advisor == nil
        subject.update_attributes!(advisor_id: advisor.id)
      end
    end
  end
end

def make_complaints
  puts "Making Complaints"
  days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
  80.times do
    studnets = Student.all(limit: 20 , order: "RANDOM()" )
    title = Faker::Lorem.sentence(1).chomp('.')
    description = Faker::Lorem.paragraphs(rand(2..8)).join('')
    studnets.each do |student|
      subjects = student.subjects.all(limit: 3) if student.subjects
      subjects.each do |subject|
        priority = [1,2,3]
        time = (Time.now - 1.days) + days.sample.days
        Ticket.create!(created_at: time, title: title, description: description, student_id: student.id, subject_id: subject.id, priority_id: priority.sample)
        ticket = Ticket.last
        if ticket.priority.priority_name == 'High'
          due = ticket.created_at.to_date + 2.days
          ticket.update_attributes(due: due)
        elsif ticket.priority.priority_name == 'Normal'
          due = ticket.created_at.to_date + 7.days
          ticket.update_attributes(due: due)
        elsif ticket.priority.priority_name == 'Low'
          due = ticket.created_at.to_date + 10.days
          ticket.update_attributes(due: due)
        end
        advisor_id = subject.advisor.id if subject.advisor
        ticket_id = Ticket.last.id
        status = [1,2,3,4,5]
        TicketStatus.create!(status_id: status.sample,ticket_id: ticket_id, advisor_id: advisor_id )
      end
    end
  end
end