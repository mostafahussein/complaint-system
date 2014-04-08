<<<<<<< HEAD
# == Schema Information
#
# Table name: employee_positions
#
#  id             :integer          not null, primary key
#  position_title :string(30)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
=======
# ## Schema Information
#
# Table name: `employee_positions`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`id`**              | `integer`          | `not null, primary key`
# **`position_title`**  | `string(30)`       |
# **`created_at`**      | `datetime`         | `not null`
# **`updated_at`**      | `datetime`         | `not null`
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

class EmployeePosition < ActiveRecord::Base
  attr_accessible :position_title
  has_many :employees
end
