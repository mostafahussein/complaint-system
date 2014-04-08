<<<<<<< HEAD
# == Schema Information
#
# Table name: subject_fields
#
#  id         :integer          not null, primary key
#  field_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

=======
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
class SubjectField < ActiveRecord::Base
  attr_accessible :field_name
  has_many :suggestions
end
