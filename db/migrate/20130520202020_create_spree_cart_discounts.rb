class CreateSpreeCartDiscounts < ActiveRecord::Migration
  def self.up
    create_table :spree_cart_discounts do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :position
      t.references :product
      t.references :level
      t.timestamps
    end
    create_table :spree_levels do |t|
      t.integer :level
      t.decimal :minimal_price, :precision => 8, :scale => 2
    end
  end

  def self.down
    drop_table :spree_cart_discounts
    drop_table :spree_levels
  end
end
