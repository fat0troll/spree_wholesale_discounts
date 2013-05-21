Spree::Product.class_eval do
  has_many :cart_discounts, :dependent => :destroy
  accepts_nested_attributes_for :cart_discounts, :allow_destroy => true

  attr_accessible :cart_discounts_attributes

  # Calculating the price based on cart's wholesale level
  def discount(level=0)
    #raise 'DEADBEEF'
    if self.cart_discounts.count == 0 or level == 0 or level.nil?
      return self.price
    else
      if self.cart_discounts.find_by_level_id(level).nil?
        return self.cart_discounts.sort_by_level.first.amount
      else
        return self.cart_discounts.find_by_level_id(level).amount
      end
    end
  end
end
