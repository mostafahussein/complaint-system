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

EmployeeDepartment.create([
  {department_name: 'software engineering'},
  {department_name: 'student advisor'}
  ])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Employee Positions'

EmployeePosition.create([
  {position_title: 'head of department'},
  {position_title: 'staff'},
  {position_title: 'advisor'}
  ])

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
  {ticket_status: 'closed'}
  ])

#----------------------------------------------------------------------------------------------------------------------#

puts 'Creating Priorities'
Priority.create([
  {priority_name: 'high', background: '#FEE7E7', color:'black'},
  {priority_name: 'normal', background: '#FFFFF0', color: 'black'},
  {priority_name: 'low', background: '#DDFFDD', color: 'black'}
  ])
#----------------------------------------------------------------------------------------------------------------------#
puts 'Creating Batches and Sections'
Batch.create([
  {batch_name: 'First Year'},
  {batch_name: 'Second Year'},
  {batch_name: 'Third Year'},
  {batch_name: 'Fourth Year'}
  ])

Section.create([
  {section_name: 'Section 1', batch_id: 1},
  {section_name: 'Section 2', batch_id: 1},
  {section_name: 'Section 1', batch_id: 2},
  {section_name: 'Section 2', batch_id: 2},
  {section_name: 'Section 1', batch_id: 3},
  {section_name: 'Section 2', batch_id: 3},
  {section_name: 'Section 1', batch_id: 4},
  {section_name: 'Section 2', batch_id: 4}
  ])
#----------------------------------------------------------------------------------------------------------------------#
puts 'Creating Courses'
Subject.create([
  {subject_code:'CS-1109' , subject_title:'Fundamental Programming Concepts'},
  {subject_code:'CS-1110' , subject_title:'Introduction to Computing Using Python'},
  {subject_code:'CS-1112' , subject_title:'Introduction to Computing Using MATLAB'},
  {subject_code:'CS-1115' , subject_title:'Introduction to Computational Science and Engineering Using Matlab Graphical User Interfaces'},
  {subject_code:'CS-1130' , subject_title:'Transition to Object-Oriented Programming'},
  {subject_code:'CS-1300' , subject_title:'Introductory Design and Programming for the Web'},
  {subject_code:'CS-1305' , subject_title:'Computation and Culture in a Digital Age'},
  {subject_code:'CS-1330' , subject_title:'FWS: How Digital Technology is Reshaping Privacy'},
  {subject_code:'CS-1610' , subject_title:'Computing in the Arts'},
  {subject_code:'CS-1620' , subject_title:'Visual Imaging in the Electronic Age'},
  {subject_code:'CS-1710' , subject_title:'Introduction to Cognitive Science'},
  {subject_code:'CS-1810' , subject_title:'Topics in the Analysis and Transmission of Knowledge and Information'},
  {subject_code:'CS-2022' , subject_title:'Introduction to C'},
  {subject_code:'CS-2024' , subject_title:'C++ Programming'},
  {subject_code:'CS-2043' , subject_title:'UNIX Tools'},
  {subject_code:'CS-2044' , subject_title:'Advanced UNIX Programming and Tools'},
  {subject_code:'CS-2046' , subject_title:'Introduction to Mobile Application Development'},
  {subject_code:'CS-2048' , subject_title:'Introduction to iPhone App Development'},
  {subject_code:'CS-2049' , subject_title:'Intermediate iPhone App Development'},
  {subject_code:'CS-2110' , subject_title:'Object-Oriented Programming and Data Structures'},
  {subject_code:'CS-2111' , subject_title:'Programming Practicum'},
  {subject_code:'CS-2300' , subject_title:'Intermediate Design and Programming for the Web'},
  {subject_code:'CS-2770' , subject_title:'Excursions in Computational Sustainability'},
  {subject_code:'CS-2800' , subject_title:'Discrete Structures'},
  {subject_code:'CS-2850' , subject_title:'Networks'},
  {subject_code:'CS-3110' , subject_title:'Data Structures and Functional Programming'},
  {subject_code:'CS-3152' , subject_title:'Introduction to Computer Game Architecture'},
  {subject_code:'CS-3220' , subject_title:'Introduction to Scientific Computation'},
  {subject_code:'CS-3300' , subject_title:'Data-Driven Web Applications'},
  {subject_code:'CS-3410' , subject_title:'Computer System Organization and Programming'},
  {subject_code:'CS-3420' , subject_title:'Embedded Systems'},
  {subject_code:'CS-3740' , subject_title:'Computational Linguistics'},
  {subject_code:'CS-3758' , subject_title:'Autonomous Mobile Robots'},
  {subject_code:'CS-3810' , subject_title:'Introduction to Theory of Computing'},
  {subject_code:'CS-4090' , subject_title:'Teaching Experience in Computer Science'},
  {subject_code:'CS-4110' , subject_title:'Programming Languages and Logics'},
  {subject_code:'CS-4120' , subject_title:'Introduction to Compilers'},
  {subject_code:'CS-4121' , subject_title:'Practicum in Compilers'},
  {subject_code:'CS-4152' , subject_title:'Advanced Topics in Computer Game Architecture'},
  {subject_code:'CS-4210' , subject_title:'Numerical Analysis and Differential Equations'},
  {subject_code:'CS-4300' , subject_title:'Information Retrieval'},
  {subject_code:'CS-4302' , subject_title:'Web Information Systems'}
  ])
#----------------------------------------------------------------------------------------------------------------------#
puts 'Creating Categories'
Category.create([
  {category_name: 'exam'},
  {category_name:"subject material"},
  {category_name: 'classroom'},
  {category_name: "subject instructor"}
  ])
#----------------------------------------------------------------------------------------------------------------------#
puts 'Creating Survey'
Survey.create([{survey_name: 'Course Evaluation'}])
#----------------------------------------------------------------------------------------------------------------------#
puts 'Creating Questions'
Question.create([
  {survey_id: 1 , required_question: true , question_type: 'Choose From A List', content: 'Reason course was taken:'},
  {survey_id: 1 , required_question: true , question_type: 'Multiple Choice', content: 'Please rate your overall satisfaction with the Professor-Course Intructor:'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your evel of agreement with the following aspects of the course:' , content: 'Syllabus accurately described course content and objectives'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your evel of agreement with the following aspects of the course:' , content: 'Assignments were reasonable and appropriate'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your evel of agreement with the following aspects of the course:' , content: 'Course pace and difficulty were appropriate'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your evel of agreement with the following aspects of the course:' , content: 'Exams and quizzes reflected important course aspects'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your evel of agreement with the following aspects of the course:' , content: 'Fellow students were academically prepared for the course'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your evel of agreement with the following aspects of the course:' , content: 'Class size was not too large for the subject and format'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your evel of agreement with the following aspects of the course:' , content: 'I would recommend this course to other students'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your level of agreement with the following aspects of the textbook-resources:' , content: 'The required textbooks adequately covered the subject'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your level of agreement with the following aspects of the textbook-resources:' , content: 'Textbooks and other instructional material were effectively used'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your level of agreement with the following aspects of the textbook-resources:' , content: 'I would recommend that current textbooks continue to be used'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your level of agreement with the following aspects of the benefits derived from the course:' , content: 'The course increased my interest in the subject'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your level of agreement with the following aspects of the benefits derived from the course:' , content: 'Having completed the course, I feel knowledgeable in the subject'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your level of agreement with the following aspects of the benefits derived from the course:' , content: 'The course contributed to the completeness of my education'},
  {survey_id: 1 , required_question: true , question_type: 'Grid', help_text:'Please rate your level of agreement with the following aspects of the benefits derived from the course:' , content: 'Overall, the course and instructor met my expectations'},
  {survey_id: 1 , required_question: true , question_type: 'Pragraph Text', content: 'Please describe any positive and/or negative factors about the course you would like us to be aware of:'}
  ])
#----------------------------------------------------------------------------------------------------------------------#
puts 'Creating Answers'
Answer.create([
  {question_id:1 , content:'require for major'},
  {question_id:1 , content: 'require for minor'},
  {question_id:1 , content: 'elective'},

  {question_id:2 , content: 'Very Dissatisfied'},
  {question_id:2 , content: 'Dissatisfied'},
  {question_id:2 , content: 'Neutral'},
  {question_id:2 , content: 'Satisfied'},
  {question_id:2 , content: 'Very Satisfied'},

  {question_id:3 , content: 'Strongly Disagree'},
  {question_id:3 , content: 'Disagree'},
  {question_id:3 , content: 'Neutral'},
  {question_id:3 , content: 'Agree'},
  {question_id:3 , content: 'Strongly Agree'},

  {question_id:4 , content: 'Strongly Disagree'},
  {question_id:4 , content: 'Disagree'},
  {question_id:4 , content: 'Neutral'},
  {question_id:4 , content: 'Agree'},
  {question_id:4 , content: 'Strongly Agree'},

  {question_id:5 , content: 'Strongly Disagree'},
  {question_id:5 , content: 'Disagree'},
  {question_id:5 , content: 'Neutral'},
  {question_id:5 , content: 'Agree'},
  {question_id:5 , content: 'Strongly Agree'},

  {question_id:6 , content: 'Strongly Disagree'},
  {question_id:6 , content: 'Disagree'},
  {question_id:6 , content: 'Neutral'},
  {question_id:6 , content: 'Agree'},
  {question_id:6 , content: 'Strongly Agree'},

  {question_id:7 , content: 'Strongly Disagree'},
  {question_id:7 , content: 'Disagree'},
  {question_id:7 , content: 'Neutral'},
  {question_id:7 , content: 'Agree'},
  {question_id:7 , content: 'Strongly Agree'},

  {question_id:8 , content: 'Strongly Disagree'},
  {question_id:8 , content: 'Disagree'},
  {question_id:8 , content: 'Neutral'},
  {question_id:8 , content: 'Agree'},
  {question_id:8 , content: 'Strongly Agree'},

  {question_id:9 , content: 'Strongly Disagree'},
  {question_id:9 , content: 'Disagree'},
  {question_id:9 , content: 'Neutral'},
  {question_id:9 , content: 'Agree'},
  {question_id:9 , content: 'Strongly Agree'},

  {question_id:10 , content: 'Strongly Disagree'},
  {question_id:10 , content: 'Disagree'},
  {question_id:10 , content: 'Neutral'},
  {question_id:10 , content: 'Agree'},
  {question_id:10 , content: 'Strongly Agree'},

  {question_id:11 , content: 'Strongly Disagree'},
  {question_id:11 , content: 'Disagree'},
  {question_id:11 , content: 'Neutral'},
  {question_id:11 , content: 'Agree'},
  {question_id:11 , content: 'Strongly Agree'},

  {question_id:12 , content: 'Strongly Disagree'},
  {question_id:12 , content: 'Disagree'},
  {question_id:12 , content: 'Neutral'},
  {question_id:12 , content: 'Agree'},
  {question_id:12 , content: 'Strongly Agree'},

  {question_id:13 , content: 'Strongly Disagree'},
  {question_id:13 , content: 'Disagree'},
  {question_id:13 , content: 'Neutral'},
  {question_id:13 , content: 'Agree'},
  {question_id:13 , content: 'Strongly Agree'},

  {question_id:14 , content: 'Strongly Disagree'},
  {question_id:14 , content: 'Disagree'},
  {question_id:14 , content: 'Neutral'},
  {question_id:14 , content: 'Agree'},
  {question_id:14 , content: 'Strongly Agree'},

  {question_id:15 , content: 'Strongly Disagree'},
  {question_id:15 , content: 'Disagree'},
  {question_id:15 , content: 'Neutral'},
  {question_id:15 , content: 'Agree'},
  {question_id:15 , content: 'Strongly Agree'},

  {question_id:16 , content: 'Strongly Disagree'},
  {question_id:16 , content: 'Disagree'},
  {question_id:16 , content: 'Neutral'},
  {question_id:16 , content: 'Agree'},
  {question_id:16 , content: 'Strongly Agree'}
  ])
#----------------------------------------------------------------------------------------------------------------------#
puts 'fields'
SubjectField.create(field_name: 'Theoretical')
SubjectField.create(field_name: 'Practical')
SubjectField.create(field_name: 'Project')

#Suggestion.create(subject_field_id:, content:, student_id:, subject_id:, title:)

puts 'All Seeds Completed.'
