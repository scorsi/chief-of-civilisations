class AbstractBuilding < ApplicationRecord

  belongs_to :main

  has_many :abstract_building_tiers

  def self.find_by_main_name(name)
    main = Main.find_by_name name
    return nil if main.nil?
    AbstractBuilding.find_by_main_id main.id
  end

  def name
    main.name.capitalize
  end

  def description
    main.description
  end

  def tiers
    abstract_building_tiers
  end

end
