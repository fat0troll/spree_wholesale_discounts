class CreateSpreeCartDiscounts < ActiveRecord::Migration
  def self.up
    create_table :spree_cart_discountss do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.decimal :minimal_price, :precision => 8, :scale => 2
      t.references :variant
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_group_prices
  end
end
