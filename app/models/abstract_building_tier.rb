class AbstractBuildingTier < ApplicationRecord

  belongs_to :abstract_building

  has_many :abstract_building_tier_buildings
  has_many :abstract_building_tier_primary_resources
  has_many :abstract_building_tier_technologies

  def buildings
    abstract_building_tier_buildings
  end

  def primary_resources
    abstract_building_tier_primary_resources
  end

  def technologies
    abstract_building_tier_technologies
  end

end
