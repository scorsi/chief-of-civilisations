class AbstractBuildingTierBuilding < ApplicationRecord

  belongs_to :abstract_building_tier
  belongs_to :abstract_building

  def require_building
    abstract_building
  end

  def require
    abstract_building
  end

end
