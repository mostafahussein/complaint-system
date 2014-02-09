# ## Schema Information
#
# Table name: `responses`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`canned_response`**  | `string(255)`      |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
#

class Response < ActiveRecord::Base
  attr_accessible :canned_response
  
  def to_label
    canned_response
  end
end
