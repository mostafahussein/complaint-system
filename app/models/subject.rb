# == Schema Information
#
# Table name: subjects
#
#  id            :integer          not null, primary key
#  subject_title :string(30)
#  subjectCode   :string(10)
#  employee_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Subject < ActiveRecord::Base
  attr_accessible :subject_title, :subjectCode, :advisor_id
  has_many :attends
  has_many :students, :through => :attends
  belongs_to :advisor, class_name: 'Advisor'
  
  def to_label
    subject_title
  end
end
