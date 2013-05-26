Spree::LineItem.class_eval do
  def set_normal_price
    self.order.define_level
    normal_price = self.product.discount(self.order.level_id)
    Spree::LineItem.update_all({price: normal_price}, {id: self.id})
  end

  before_save do
    set_normal_price
  end
end
