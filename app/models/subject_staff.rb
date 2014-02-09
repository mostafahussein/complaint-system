# ## Schema Information
#
# Table name: `subject_staffs`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`staff_id`**    | `integer`          |
# **`advisor_id`**  | `integer`          |
# **`subject_id`**  | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class SubjectStaff < ActiveRecord::Base
  attr_accessible :staff_id, :subject_id, :advisor_id
  belongs_to :staff, class_name: 'Staff'
  belongs_to :advisor, class_name: 'Advisor'
  belongs_to :subject
end
