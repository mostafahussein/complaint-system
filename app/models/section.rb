# == Schema Information
#
# Table name: sections
#
#  id           :integer          not null, primary key
#  section_name :string(255)
#  batch_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Section < ActiveRecord::Base
  attr_accessible :section_name, :batch_id
  belongs_to :batch
  has_many :students
end
