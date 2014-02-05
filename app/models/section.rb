class Section < ActiveRecord::Base
  attr_accessible :section_name
  belongs_to :batch
  has_many :students
end
