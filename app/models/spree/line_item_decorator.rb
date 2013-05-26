Spree::LineItem.class_eval do
  def price
    return self.product.discount(self.order.level_id)
  end

  after_create do
    self.order.save
  end

  after_update do
    self.order.save
  end

  after_save do
    self.order.save
  end
end
