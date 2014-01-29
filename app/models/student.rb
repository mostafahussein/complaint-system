# == Schema Information
#
# Table name: students
#
#  id           :integer          not null, primary key
#  full_name    :string(30)
#  batch_name   :string(30)
#  section_name :string(30)
#  gender       :string(6)
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Student < ActiveRecord::Base
  attr_accessible :full_name, :gender, :batch_name, :section_name, :user_id, :subject_ids
  belongs_to :user
  has_many :attends
  has_many :subjects, :through => :attends
  has_many :tickets

end
