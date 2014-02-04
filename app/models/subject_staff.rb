class SubjectStaff < ActiveRecord::Base
  attr_accessible :staff_id, :subject_id, :advisor_id
  belongs_to :staff, class_name: 'Staff'
  belongs_to :advisor, class_name: 'Advisor'
  belongs_to :subject
end
