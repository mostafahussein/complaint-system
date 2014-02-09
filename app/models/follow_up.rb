# ## Schema Information
#
# Table name: `follow_ups`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`text`**         | `string(140)`      |
# **`ticket_id`**    | `integer`          |
# **`user_id`**      | `integer`          |
# **`priority_id`**  | `integer`          |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#

class FollowUp < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  attr_accessible :text, :ticket_id, :priority_id, :user_id
  belongs_to :ticket
  belongs_to :user
end
