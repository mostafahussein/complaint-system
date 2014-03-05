class Reply < ActiveRecord::Base
  attr_accessible :suggestion_id, :text, :user_id
  belongs_to :suggestion
  belongs_to :user
end
