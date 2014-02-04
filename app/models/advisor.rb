# == Schema Information
#
# Table name: employees
#
#  id                     :integer          not null, primary key
#  full_name              :string(30)
#  gender                 :string(6)
#  type                   :string(15)
#  user_id                :integer
#  employee_department_id :integer
#  employee_position_id   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Advisor < Employee
  has_many :ticket_statuses
  has_many :subject_staffs
  has_many :subjects, through: :subject_staffs
end
