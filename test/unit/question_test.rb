<<<<<<< HEAD
# == Schema Information
#
# Table name: questions
#
#  id                :integer          not null, primary key
#  survey_id         :integer
#  content           :string(255)
#  question_type     :string(255)
#  help_text         :string(255)
#  required_question :boolean          default(TRUE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
=======
# ## Schema Information
#
# Table name: `questions`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`survey_id`**   | `integer`          |
# **`content`**     | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
