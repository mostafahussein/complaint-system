class Category < ActiveRecord::Base
  attr_accessible :category_name
  has_many :tickets
end
