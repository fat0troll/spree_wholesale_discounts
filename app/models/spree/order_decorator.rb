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
        if li.product.cart_discounts.empty?
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
    level_id = 0
    # Returning true level based on "true" price
    # If we haven't first level in database, we haven't levels at all!
    unless Spree::Level.find_by_level(1).nil?
      # Very simple algorhythm: loop over all levels, from highest to lowest and checking, if it's minimal price smaller
      # than cart's amount. When true -- it's our level ;) If all levels returns false -- our level is zero.
      Spree::Level.all.sort_by(&:level).reverse.each do |lvl|
        if lvl.minimal_price > calculate_price_for_level(lvl.level - 1)
          # Price is smaller, going ahead, unless level was first -- if level was first, and statement still true -- we're at
          # zero level :)
          unless lvl.level == 1
            next
          end
        else
          # Price is bigger, fuck yeah!
          level_id = lvl.id
          break
        end
      end
    end
    Spree::Order.update_all({level_id: level_id}, {:id => self.id})
    return level_id
  end
end
