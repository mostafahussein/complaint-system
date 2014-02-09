# ## Schema Information
#
# Table name: `students`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`full_name`**   | `string(30)`       |
# **`gender`**      | `string(6)`        |
# **`user_id`**     | `integer`          |
# **`batch_id`**    | `integer`          |
# **`section_id`**  | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

class Student < ActiveRecord::Base
  include Modules::DefaultValues
  attr_accessible :full_name, :gender, :batch_id, :section_id, :user_id, :subject_ids
  belongs_to :user
  belongs_to :batch
  belongs_to :section
  has_many :attends
  has_many :subjects, :through => :attends
  has_many :tickets

end
