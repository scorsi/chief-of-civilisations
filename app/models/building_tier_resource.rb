
class BuildingTierResource < ApplicationRecord

  belongs_to :building_tier
  belongs_to :resource

  def name
    resource.name
  end

end