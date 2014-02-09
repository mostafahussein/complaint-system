# ## Schema Information
#
# Table name: `employees`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`full_name`**               | `string(30)`       |
# **`gender`**                  | `string(6)`        |
# **`type`**                    | `string(15)`       |
# **`user_id`**                 | `integer`          |
# **`employee_department_id`**  | `integer`          |
# **`employee_position_id`**    | `integer`          |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#

class Employee < ActiveRecord::Base
  include Modules::DefaultValues
  attr_accessible :full_name, :gender,
  :user_id, :employee_department_id, :employee_position_id, :subject_ids, :type
  belongs_to :user
  belongs_to :employee_department
  belongs_to :employee_position
end
