class Item < ActiveRecord::Base
  attr_accessible :level, :name
  
  has_many :gifts, :as => :item

  scope :allowed_for, ->(user) { where('level <= ?', user.is_a?(User) ? user.level : User.find(user).level) }
end
