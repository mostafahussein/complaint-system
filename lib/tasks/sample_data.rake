namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    Faker::Config.locale = :en
    make_subjects
    make_employees_and_students
    # make_employees_and_students_as_users
    # attended_subjects
    # assign_advisors_to_subjects
    # make_complaints
  end
end

def make_subjects
  puts "Making Subjects"
    20.times do
      subject_title = Faker::Lorem.word
      subjectCode = Faker::Address.zip_code
      Subject.create!([{subject_title: subject_title, subjectCode: subjectCode }])
    end
end

def make_employees_and_students
  puts "Making Employees and Students"
   100.times do
    full_name = Faker::Name.name
    gender = ["f" , "m"]
    Staff.create!([{full_name: full_name, gender: gender.sample, employee_department_id: 1, employee_position_id: 2}])
    full_name = Faker::Name.name
    gender = ["f" , "m"]
    Advisor.create!([{full_name: full_name, gender: gender.sample, employee_department_id: 2, employee_position_id: 3}])
    full_name = Faker::Name.name
    gender = ["f" , "m"]
    Student.create!([{full_name: full_name, gender: gender.sample, batch_name: 'Batch 1', section_name: 'Section 1'}])
    full_name = Faker::Name.name
    gender = ["f" , "m"]
    Student.create!([{full_name: full_name, gender: gender.sample, batch_name: 'Batch 2', section_name: 'Section 2'}])
    full_name = Faker::Name.name
    gender = ["f" , "m"]
    Student.create!([{full_name: full_name, gender: gender.sample, batch_name: 'Batch 3', section_name: 'Section 3'}])
    full_name = Faker::Name.name
    gender = ["f" , "m"]
    Student.create!([{full_name: full_name, gender: gender.sample, batch_name: 'Batch 4', section_name: 'Section 4'}])
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
  5.times do
    students = Student.all(limit: 100, order: "RANDOM()")
    subjects = Subject.all
    students.each do |student|
      subjects.each do |subject|
        if Attend.where(student_id: student.id, subject_id: subject.id).exists? == false
          Attend.create!([{student_id: student.id, subject_id: subject.id}])
        end
      end
    end
  end
end

def assign_advisors_to_subjects
  5.times do
    advisor = Advisor.first(order: "RANDOM()")
    subjects = Subject.all(limit: 3, order: "RANDOM()")
    subjects.each do |subject|
      if subject.employee == nil
        subject.update_attributes!(employee_id: advisor.id)
      end
    end
  end
end

def make_complaints
   50.times do
     studnets = Student.all(limit: 10, order: "RANDOM()")
     title = Faker::Lorem.sentence(1).chomp('.')
     description = Faker::Lorem.paragraphs(rand(2..8)).join('')
     studnets.each { |student| student.tickets.create!(title: title, description: description) }
   end
end