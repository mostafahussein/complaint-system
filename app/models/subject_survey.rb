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
  attr_accessible :subject_id , :survey_id
  belongs_to :survey
  belongs_to :subject
end
