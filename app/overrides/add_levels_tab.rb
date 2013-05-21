Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_wb_admin_tab",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text => %q{<%= configurations_sidebar_menu_item t(:disco_levels), admin_levels_path %>},
                     :disabled => false)
