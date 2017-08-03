
class GatherBuilding < ApplicationRecord

  belongs_to :building
  belongs_to :resource

  has_many :gather_building_tiers

  alias_attribute :tiers, :gather_building_tiers

  def self.find_by_building_name(name)
    building = Building.find_by_main_name name
    GatherBuilding.find_by_building_id building.id unless building.nil?
  end

  def collect_capacity(tier)
    tier = tiers.where('tier <= :value', value: tier).order(tier: :desc).first
    return 0 if tier.nil?
    tier.capacity
  end

  def collect_quantity(tier, level, last_collect_time)
    tier = tiers.where('tier <= :value', value: tier).order(tier: :desc).first
    time = Time.now.to_time.to_f - last_collect_time.to_time.to_f
    quantity = tier.rps * time
    (1..level - 1).each do
      quantity *= (1 + tier.increase)
    end
    return tier.capacity if quantity > tier.capacity
    quantity.round
  end

end