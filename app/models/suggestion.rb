class Suggestion < ActiveRecord::Base
  attr_accessible :subject_field_id, :content, :student_id, :subject_id, :title, :replies_attributes
  belongs_to :subject_field
  belongs_to :student
  belongs_to :subject
  has_many :votes
  has_many :replies
  accepts_nested_attributes_for :replies
end
