class Spree::CartDiscount < ActiveRecord::Base
  belongs_to :variant, :touch => true
  acts_as_list :scope => :variant
  attr_accessible :variant, :minimal_price, :amount

  validates :variant, presence: true # link to variant, that will be used
  validates :minimal_price, presence: true # minimal price. If we have variant with price, which beats this, we use that variant.
  # My very bad English fails. Someone, explain it...
  validates :amount, presence: true # price, fucking price...
end
