# ## Schema Information
#
# Table name: `kbs`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`faq_question`**  | `string(255)`      |
# **`faq_answer`**    | `string(255)`      |
# **`category`**      | `string(255)`      |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
#

require 'test_helper'

class KbTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
