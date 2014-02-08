# == Schema Information
#
# Table name: subjects
#
#  id            :integer          not null, primary key
#  subject_title :string(30)
#  subject_code   :string(10)
#  employee_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Subject < ActiveRecord::Base
  attr_accessible :subject_title, :subject_code
  has_many :attends
  has_many :students, :through => :attends
  has_many :subject_staffs
  has_many :staffs, class_name: 'Staff', through: :subject_staffs
  has_many :advisors , class_name: 'Advisor', through: :subject_staffs
  
  def to_label
    subject_title
  end
end