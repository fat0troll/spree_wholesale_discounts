class Spree::Level < ActiveRecord::Base
  attr_accessible :minimal_price, :level

  validates :level, presence: true
  validates :minimal_price, presence: true
end
