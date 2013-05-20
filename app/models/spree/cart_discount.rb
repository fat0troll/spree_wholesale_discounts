class Spree::CartDiscount < ActiveRecord::Base
  belongs_to :variant, :touch => true
  belongs_to :level
  acts_as_list :scope => :variant
  attr_accessible :variant, :level_id, :amount

  validates :variant, presence: true # link to variant, that will be used
  validates :level_id, presence: true
  validates :amount, presence: true # price, fucking price...
end
