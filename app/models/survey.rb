class Survey < ActiveRecord::Base
  attr_accessible :survey_name, :questions_attributes
  has_many :questions
  accepts_nested_attributes_for :questions, allow_destroy: true
end
