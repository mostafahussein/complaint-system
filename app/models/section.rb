class Section < ActiveRecord::Base
  attr_accessible :section_name, :batch_id
  belongs_to :batch
  has_many :students
end
