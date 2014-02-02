class Response < ActiveRecord::Base
  attr_accessible :canned_response
  
  def to_label
    canned_response
  end
end
