# == Schema Information
#
# Table name: statuses
#
#  id            :integer          not null, primary key
#  ticket_status :string(10)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Status < ActiveRecord::Base
  attr_accessible :ticket_status
  has_many :ticket_statuses
end
