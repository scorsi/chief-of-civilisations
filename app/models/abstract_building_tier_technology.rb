class AbstractBuildingTierTechnology < ApplicationRecord

  belongs_to :abstract_building_tier
  belongs_to :abstract_technology

  def require_technology
    abstract_technology
  end

  def require
    abstract_technology
  end

end
