class Spree::Admin::LevelsController < Spree::Admin::ResourceController
  def index
    @levels = Spree::Level.all
  end
end
