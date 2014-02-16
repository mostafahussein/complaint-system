# ## Schema Information
#
# Table name: `subject_surveys`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`survey_id`**   | `integer`          |
# **`subject_id`**  | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class SubjectSurvey < ActiveRecord::Base
  attr_accessible :subject_id , :survey_id, :student_id , :question_id, :answer_id
  belongs_to :subject
  belongs_to :student
  belongs_to :question
  belongs_to :answer
end
