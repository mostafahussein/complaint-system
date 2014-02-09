# ## Schema Information
#
# Table name: `surveys`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`survey_name`**  | `string(255)`      |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#

class Survey < ActiveRecord::Base
  attr_accessible :survey_name, :questions_attributes
  has_many :questions
  has_many :subject_surveys
  has_many :subjects, through: :subject_surveys
  accepts_nested_attributes_for :questions, allow_destroy: true
end
