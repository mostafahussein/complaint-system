<<<<<<< HEAD
# == Schema Information
#
# Table name: priorities
#
#  id            :integer          not null, primary key
#  priority_name :string(15)
#  color         :string(10)
#  background    :string(10)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_priorities_on_priority_name  (priority_name)
=======
# ## Schema Information
#
# Table name: `priorities`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`priority_name`**  | `string(15)`       |
# **`color`**          | `string(10)`       |
# **`background`**     | `string(10)`       |
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_priorities_on_priority_name`:
#     * **`priority_name`**
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

class Priority < ActiveRecord::Base
  attr_accessible :priority_name, :color, :background
  has_many :tickets
end
