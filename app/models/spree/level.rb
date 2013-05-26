class Spree::Level < ActiveRecord::Base
  attr_accessible :minimal_price, :level

  validates :level, presence: true
  validates :minimal_price, presence: true
  validates_uniqueness_of :level
  validate :level_sanity

  def destroy
    if Spree::CartDiscount.find(:all, :conditions => ["level_id = ?", self.id]).empty?
      super
    end
  end

  private

    def level_sanity
      if Spree::Level.find_by_level(1).nil?
        if level != 1
          errors.add(:level, (I18n.t 'errors.levels.need_first'))
        end
      else
        if Spree::Level.find_by_level(level - 1).nil?
          errors.add(:level, (I18n.t 'errors.levels.must_be_serial'))
        end
      end
    end
end
