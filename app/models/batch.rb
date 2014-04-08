<<<<<<< HEAD
# == Schema Information
#
# Table name: batches
#
#  id         :integer          not null, primary key
#  batch_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
=======
# ## Schema Information
#
# Table name: `batches`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`batch_name`**  | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

class Batch < ActiveRecord::Base
  attr_accessible :batch_name
  has_many :sections
  has_many :students
end
