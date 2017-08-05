
class GatherBuilding < ApplicationRecord

  belongs_to :building
  belongs_to :resource

  has_many :gather_building_tiers

  alias_attribute :tiers, :gather_building_tiers

end