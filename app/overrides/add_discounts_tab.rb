Deface::Override.new(:virtual_path => "spree/admin/shared/_product_tabs",
                     :name => "add_wb_admin_tab",
                     :insert_bottom => "[data-hook='admin_product_tabs']",
                     :partial => "spree/admin/cart_discounts/tab",
                     :disabled => false)
