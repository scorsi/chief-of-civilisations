class AbstractBuildingTierPrimaryResource < ApplicationRecord

  belongs_to :abstract_building_tier
  belongs_to :abstract_primary_resource

  def require_primary_resource
    abstract_primary_resource
  end

  def require
    abstract_primary_resource
  end

end
