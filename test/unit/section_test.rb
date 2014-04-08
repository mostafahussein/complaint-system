<<<<<<< HEAD
# == Schema Information
#
# Table name: sections
#
#  id           :integer          not null, primary key
#  section_name :string(255)
#  batch_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
=======
# ## Schema Information
#
# Table name: `sections`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`section_name`**  | `string(255)`      |
# **`batch_id`**      | `integer`          |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
