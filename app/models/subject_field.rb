class SubjectField < ActiveRecord::Base
  attr_accessible :field_name
  has_many :suggestions
end
