<<<<<<< HEAD
# == Schema Information
#
# Table name: responses
#
#  id              :integer          not null, primary key
#  canned_response :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
=======
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
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

class Response < ActiveRecord::Base
  attr_accessible :canned_response
  
  def to_label
    canned_response
  end
end
