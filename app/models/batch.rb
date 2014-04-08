# == Schema Information
#
# Table name: batches
#
#  id         :integer          not null, primary key
#  batch_name :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Batch < ActiveRecord::Base
  attr_accessible :batch_name
  has_many :sections
  has_many :students
end
