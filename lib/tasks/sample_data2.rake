namespace :db do
  desc 'Fill database with sample data'
  task update_sample: :environment do
    Faker::Config.locale = :en
     #make_employees_and_students_as_users
     #attended_subjects
     #assigned_subjects
     #make_complaints
     #canned_responses
     #faqs
    suggestions
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
      if (employee.employee_department.department_name == "software engineering" && employee.employee_position.position_title == "head of department")
        user.role = 'head of department'
      elsif (employee.employee_department.department_name == "software engineering" && employee.employee_position.position_title == "staff")
        user.role = "staff"
      elsif (employee.employee_department.department_name == "student advisor" && employee.employee_position.position_title == "advisor")
        user.role = "advisor"
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
      user.role = "student"
    end
    user_id = User.last.id
    student.update_attributes(user_id: user_id)
  end
end

def attended_subjects
  puts "Attended Subjects"
  students = Student.all(limit: 200)
  subjects = Subject.all(limit: 5, order: "RANDOM()")
  students.each do |student|
    subjects.each do |subject|
      if Attend.where(student_id: student.id, subject_id: subject.id).exists? == false
        Attend.create!([{student_id: student.id, subject_id: subject.id}])
      end
    end
  end
end

def assigned_subjects
  puts "Assign Advisors and Staff to Subjects"
  30.times do
    advisors = Advisor.all(limit: 5, order: "RANDOM()")
    staffs = Staff.all(limit: 10, order: "RANDOM()")
    subjects = Subject.all(limit: 15, order: "RANDOM()")
    advisors.each do |advisor|
      staffs.each do |staff|
        subjects.each do |subject|
          if SubjectStaff.where(advisor_id: advisor.id, staff_id: staff.id,subject_id: subject.id).exists? == false && SubjectStaff.where(subject_id: subject.id).exists? == false && SubjectStaff.where(staff_id: staff.id).exists? == false && SubjectStaff.where(advisor_id: advisor.id).exists? == false
            SubjectStaff.create!([{advisor_id: advisor.id, staff_id: staff.id,subject_id: subject.id}])
          end
        end
      end
    end
  end
end

# def assign_advisors_and_staff_to_subjects
#   puts "Assign Advisors and Staff to Subjects"
#   20.times do
#     advisor = Advisor.all(limit:1,order: "RANDOM()").first
#     staff = Staff.all(limit:1,order: "RANDOM()").first
#     subjects = Subject.all(limit: 1, order: "RANDOM()")
#     subjects.each do |subject|
#       if subject.advisor_id == nil && subject.staff_id == nil
#         subject.update_attributes!(advisor_id: advisor.id, staff_id: staff.id)
#       end
#     end
#   end
# end

def make_complaints
  puts "Making Complaints"
  days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
  40.times do
    studnets = Student.all(limit: 40 , order: "RANDOM()" )
    description = Faker::Lorem.paragraphs(rand(2..8)).join('')
    reason_of_delay = Faker::Lorem.paragraphs(rand(2..8)).join('')
    expectations = Faker::Lorem.paragraphs(rand(2..8)).join('')
    date_of_alleged_event = Time.now - 10.days
    category = [1,2,3,4]
    studnets.each do |student|
      subjects = student.subjects.all(limit: 4) if student.subjects
      subjects.each do |subject|
        priority = [1,2,3]
        time = (Time.now - 4.days) + days.sample.days
        Ticket.create!(created_at: time, description: description, student_id: student.id, subject_id: subject.id, priority_id: priority.sample, date_of_alleged_event: date_of_alleged_event,
          expectations: expectations, reason_of_delay: reason_of_delay, category_id: category.sample)
        ticket = Ticket.last
        if ticket.priority.priority_name == 'high'
          due = ticket.created_at.to_date + 2.days
          ticket.update_attributes(due: due)
        elsif ticket.priority.priority_name == 'normal'
          due = ticket.created_at.to_date + 7.days
          ticket.update_attributes(due: due)
        elsif ticket.priority.priority_name == 'low'
          due = ticket.created_at.to_date + 10.days
          ticket.update_attributes(due: due)
        end
        subject_id = ticket.subject_id
        subject_staff = SubjectStaff.where(subject_id: subject_id)
        advisor_id = subject_staff.first.advisor_id
        ticket_id = ticket.id
        status = [1,2,3,4,5]
        TicketStatus.create!(status_id: status.sample,ticket_id: ticket_id, advisor_id: advisor_id )
      end
    end
  end
end


def canned_responses
  puts 'canned_responses'
  10.times do
    canned_response = Faker::Lorem.sentence(1).chomp('.')
    Response.create(canned_response: canned_response)
  end
end

def faqs
  puts 'faqs'
  subjects =Subject.all
  20.times do
    subjects.each do |subject|
      id = subject.id
      q = Faker::Lorem.sentence(1).chomp('.')
      a = Faker::Lorem.sentence(1).chomp('.')
      Kb.create(faq_question: q , faq_answer: a, subject_id: id)
    end
  end
end

def suggestions
  puts 'suggestions'
  students = Student.all(limit: 10 , order: "RANDOM()" )
  fields = SubjectField.all
  students.each do |student|
    student.subjects.all.each do |subject|
      fields.each do |field|
        title = Faker::Lorem.sentence(1).chomp('.')
       content = Faker::Lorem.sentence(1).chomp('.')
       Suggestion.create(subject_field_id:field.id, content:content, student_id:student.id, subject_id:subject.id, title:title)
     end
   end
 end
end