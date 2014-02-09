# ## Schema Information
#
# Table name: `subject_surveys`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`survey_id`**   | `integer`          |
# **`subject_id`**  | `integer`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#

require 'test_helper'

class SubjectSurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
