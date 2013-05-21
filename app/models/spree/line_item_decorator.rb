Spree::LineItem.class_eval do
  old_copy_price = instance_method(:copy_price)
  define_method(:copy_price) do
    old_copy_price.bind(self).call
    new_price = self.price

    self.order.define_level
    vprice = self.product.discount(self.order.level_id)
    if (!new_price.nil? and vprice <= new_price) or vprice <= self.price
      return self.price = vprice
    end
    if new_price.nil?
      self.price = self.product.price
    else
      self.price = new_price
    end
  end
end
