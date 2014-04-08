<<<<<<< HEAD
# == Schema Information
#
# Table name: statuses
#
#  id            :integer          not null, primary key
#  ticket_status :string(15)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_statuses_on_ticket_status  (ticket_status)
=======
# ## Schema Information
#
# Table name: `statuses`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`ticket_status`**  | `string(15)`       |
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_statuses_on_ticket_status`:
#     * **`ticket_status`**
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

class Status < ActiveRecord::Base
  attr_accessible :ticket_status
  has_many :ticket_statuses
  has_many :tickets , through: :ticket_statuses
end
