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
#

class EmployeePosition < ActiveRecord::Base
  attr_accessible :position_title
  has_many :employees
end
