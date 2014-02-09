# ## Schema Information
#
# Table name: `employee_departments`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`department_name`**  | `string(30)`       |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
#

class EmployeeDepartment < ActiveRecord::Base
  attr_accessible :department_name
  has_many :employees
end
