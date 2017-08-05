
class GatherBuilding < ApplicationRecord

  belongs_to :building
  belongs_to :resource

  scope :building_name, ->(name) { joins(:building).where('buildings.name' => name) }
  scope :resource_name, ->(name) { joins(:resource).where('resources.name' => name) }

  has_many :gather_building_tiers

  alias_attribute :tiers, :gather_building_tiers

end