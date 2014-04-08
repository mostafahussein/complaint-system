<<<<<<< HEAD
# == Schema Information
#
# Table name: suggestions
#
#  id               :integer          not null, primary key
#  student_id       :integer
#  subject_id       :integer
#  subject_field_id :integer
#  content          :string(255)
#  title            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

=======
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
class Suggestion < ActiveRecord::Base
	scope :theoretical, joins(:subject_field).where("field_name = ?", 'Theoretical')
	scope :practical , joins(:subject_field).where("field_name = ?", 'Practical')
	scope :project , joins(:subject_field).where("field_name = ?", 'Project')
	attr_accessible :subject_field_id, :content, :student_id, :subject_id, :title, :replies_attributes
	belongs_to :subject_field
	belongs_to :student
	belongs_to :subject
	has_many :votes
	has_many :replies
	accepts_nested_attributes_for :replies
end
