class Suggestion < ActiveRecord::Base
  attr_accessible :subject_field_id, :content, :student_id, :subject_id, :title
  belongs_to :subject_field
  belongs_to :student
  belongs_to :subject
  has_many :votes
  has_many :replies
end
