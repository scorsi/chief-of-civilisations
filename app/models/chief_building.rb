
class ChiefBuilding < ApplicationRecord

  belongs_to :chief
  belongs_to :building

  def self.create_from_starters(chief)
    starter_buildings = StarterBuilding.all
    starter_buildings.each do |starter_building|
      ChiefBuilding.create chief: chief,
                           building: starter_building.building,
                           level: 1, tier: 1
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
    building.gather?
  end

  def collect_capacity
    return 0 unless collect?
    building.gather_infos.first.collect_capacity self.tier
  end

  def collect_quantity
    return 0 unless collect?
    building.gather_infos.first.collect_quantity self.tier, self.level, self.last_collect_time
  end

  def collect
    return unless collect?
    building.gather_infos.each do |gather_info|
      chief.gather_resource_of gather_info.resource.name, collect_quantity
      self.last_collect_time = Time.now
      save
    end
  end

end