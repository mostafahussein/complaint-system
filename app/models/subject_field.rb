# == Schema Information
#
# Table name: subject_fields
#
#  id         :integer          not null, primary key
#  field_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubjectField < ActiveRecord::Base
  attr_accessible :field_name
  has_many :suggestions
end
