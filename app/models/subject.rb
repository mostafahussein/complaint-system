# == Schema Information
#
# Table name: subjects
#
#  id            :integer          not null, primary key
#  subject_title :string(255)
#  subject_code  :string(10)
#  survey_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_subjects_on_subject_title  (subject_title)
#

class Subject < ActiveRecord::Base
  attr_accessible :subject_title, :subject_code, :survey_id
  has_many :attends
  has_many :students, :through => :attends
  has_many :subject_staffs
  has_many :staffs, class_name: 'Staff', through: :subject_staffs
  has_many :advisors , class_name: 'Advisor', through: :subject_staffs
  has_many :subject_surveys
  belongs_to :survey
  has_many :kbs
  has_many :suggestions

  def to_label
    subject_title
  end
end
