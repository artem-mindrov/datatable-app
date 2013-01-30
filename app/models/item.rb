class Item < ActiveRecord::Base
  attr_accessible :level, :name
  
  has_many :gifts, :as => :item
end
