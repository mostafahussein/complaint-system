<<<<<<< HEAD
# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  category_name :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
=======
# ## Schema Information
#
# Table name: `categories`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`category_name`**  | `string(255)`      |
# **`created_at`**     | `datetime`         | `not null`
# **`updated_at`**     | `datetime`         | `not null`
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
