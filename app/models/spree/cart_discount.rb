class Spree::CartDiscount < ActiveRecord::Base
  belongs_to :product, :touch => true
  belongs_to :level
  acts_as_list :scope => :product
  attr_accessible :product_id, :level_id, :amount

  validates :product_id, presence: true # link to variant, that will be used
  validates :level_id, presence: true
  validates :amount, presence: true # price, fucking price...

  scope :sort_by_level, order('level_id desc')
end
