class Notification < ActiveRecord::Base
   	attr_accessible :user_id, :activity_id, :is_read
   	alias_attribute :is_read?, :is_read
  	belongs_to :user
 	belongs_to :activity, class_name: "PublicActivity::Activity", foreign_key: :activity_id

 	def mark_as_read
    	self.update_attributes!(is_read: true)
  	end
end
