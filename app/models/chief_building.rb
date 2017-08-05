
class ChiefBuilding < ApplicationRecord

  belongs_to :chief
  belongs_to :building
  has_many :chief_gather_buildings, dependent: :destroy

  alias_attribute :gather_buildings, :chief_gather_buildings

  scope :building_name, ->(name) { joins(:building).where 'buildings.name': name }

  scope :ordered, -> { joins(:building).order 'buildings.id' }

  after_create :create_gather_buildings

  def self.create_from_starters(chief)
    starter_buildings = StarterBuilding.all
    starter_buildings.each do |starter_building|
      ChiefBuilding.create chief: chief,
                           building: starter_building.building,
                           level: 1, tier: 1
    end
  end

  def create_gather_buildings
    building.gather_infos.each do |gather_building|
      ChiefGatherBuilding.create chief_building: self,
                                 gather_building: gather_building
    end
  end

  def name
    building.name
  end

  def description
    building.description
  end

  def tiers
    building.tiers
  end

  def tier_info
    tiers.find_by_tier tier
  end

  def next_tier_info
    tiers.find_by_tier tier + 1
  end

  def next_level?
    return true if level < 5 * tier
    false
  end

  def next_tier?
    return true unless next_tier_info.nil?
    false
  end

  def upgrade_level_require_resource
    next_level = tier_info
    next_level.resources.each do |info|
      (1..level).each do
        info.quantity *= (1 + info.increase)
      end
    end
    next_level.resources
  end

  def upgrade_tier_require_resource
    next_tier_info.resources
  end

  def upgrade_require_resource
    return upgrade_level_require_resource if next_level?
    return upgrade_tier_require_resource if next_tier?
    nil
  end

  def use_resource_for_upgrade
    upgrade_require_resource.each do |resource|
      chief.use_resource_of resource.name, resource.quantity
    end
  end

  def upgrade?
    upgrade_require_resource.each do |resource|
      return false if chief.quantity_of(resource.name) < resource.quantity
    end
    true
  end

  def upgrade
    return unless upgrade?
    use_resource_for_upgrade
    if next_level?
      self.level += 1
    else
      self.level = 1
      self.tier += 1
    end
    save
  end

  def collect?
    gather_buildings.any?
  end

  def collect_info
    gather_buildings.order :id
  end

  def collect
    return unless collect?
    gather_buildings.each do |gather_building|
      quantity = gather_building.collect
      puts quantity
      chief.gather_resource_of gather_building.resource.name, quantity
    end
  end

end