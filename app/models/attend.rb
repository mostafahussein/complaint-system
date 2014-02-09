# ## Schema Information
#
# Table name: `attends`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`student_id`**  | `integer`          |
# **`subject_id`**  | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class Attend < ActiveRecord::Base
  attr_accessible :student_id, :subject_id
  belongs_to :student
  belongs_to :subject
end
