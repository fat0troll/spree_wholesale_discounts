Spree::Order.class_eval do
  belongs_to :level

  attr_accessible :level_id

  def calculate_price_for_level(level)
    # Returns price for selected level (parameter -- level number, 0 for returning price without any discounts)
    amnt = 0.0
    if level == 0
      line_items.each do |li|
        line_amnt = li.product.price * li.quantity
        amnt = amnt + line_amnt
      end
    else
      line_items.each do |li|
        if li.product.cart_discounts.nil?
          amnt = amnt + (li.amount * li.quantity)
        else
          if li.product.cart_discounts.find_by_level_id(level)
            amnt = amnt + (li.product.cart_discounts.find_by_level_id(level).amount * li.quantity)
          else
            amnt = amnt + (li.product.cart_discounts.sort_by_level.first.amount * li.quantity)
          end
        end
      end
    end
    return amnt
  end

  def define_level
    #raise 'DEADBEEF'
    level_id = self.level_id
    # Returning true level based on "true" price
    unless Spree::Level.find_by_level(1).nil?
      # If we haven't first level in database, we haven't levels at all!
      if level_id.nil? or level_id == 0
        # Checking for first level
          if calculate_price_for_level(0) > Spree::Level.find_by_level(1).minimal_price
            level_id = 1
          end
      else
        # Checking for "level balance": if we going big, we achieve better level, otherwise, going down
        cur_lvl = level_id
        next_lvl = cur_lvl + 1
        prev_lvl = cur_lvl - 1
        # Checking for next level...
        unless Spree::Level.find_by_level(next_lvl).nil?
          if calculate_price_for_level(cur_lvl) > Spree::Level.find_by_level(next_lvl).minimal_price
            level_id = next_lvl
          end
        end
        # ...otherwise going DOWN! Yarr!
        if calculate_price_for_level(prev_lvl) < Spree::Level.find_by_level(cur_lvl).minimal_price
          level_id = prev_lvl
        end
      end
    end
    self.level_id = level_id
    return level_id
  end

  after_save do
    self.define_level
  end
end
