class Spree::Admin::CartDiscountsController < Spree::Admin::ResourceController
  belongs_to 'spree/product', :find_by => :permalink
end
