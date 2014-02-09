# ## Schema Information
#
# Table name: `subjects`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`subject_title`**  | `string(255)`      |
# **`subject_code`**   | `string(10)`       |
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
#

class Subject < ActiveRecord::Base
  attr_accessible :subject_title, :subject_code
  has_many :attends
  has_many :students, :through => :attends
  has_many :subject_staffs
  has_many :staffs, class_name: 'Staff', through: :subject_staffs
  has_many :advisors , class_name: 'Advisor', through: :subject_staffs
  has_many :subject_surveys
  has_many :surveys, through: :subject_surveys
  def to_label
    subject_title
  end
end
