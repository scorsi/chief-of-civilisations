
class BuildingTier < ApplicationRecord

  belongs_to :building
  has_many :building_tier_resources

  alias_attribute :resources, :building_tier_resources

end