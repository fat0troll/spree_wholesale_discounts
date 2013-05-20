Spree::Variant.class_eval do
  has_many :cart_discounts, :dependent => :destroy
  accepts_nested_attributes_for :cart_discounts, :allow_destroy => true

  attr_accessible :cart_discounts_attributes

  # Calculating the price based on cart's total amount
  def discount(amount)
    if self.cart_discounts.count == 0
      return self.price
    else
      self.cart_discounts.each do |disco|
        if disco.minimal_price < amount
          return disco.amount
        end
      end
      # No matching discount, buy MOAR, please :)
      return self.price
    end
  end
end
