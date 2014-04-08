<<<<<<< HEAD
# == Schema Information
#
# Table name: attends
#
#  id         :integer          not null, primary key
#  student_id :integer
#  subject_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
=======
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
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

class Attend < ActiveRecord::Base
  attr_accessible :student_id, :subject_id
  belongs_to :student
  belongs_to :subject
end
