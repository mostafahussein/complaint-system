class Batch < ActiveRecord::Base
  attr_accessible :batch_name
  has_many :sections
  has_many :students
end
