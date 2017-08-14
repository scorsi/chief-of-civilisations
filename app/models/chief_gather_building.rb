
class ChiefGatherBuilding < ApplicationRecord

  belongs_to :chief_building
  belongs_to :gather_building

  scope :building_name, ->(name) { joins(gather_building: :building).where('buildings.name' => name) }
  scope :resource_name, ->(name) { joins(gather_building: :resource).where('resources.name' => name) }

  after_find :update_quantity

  @tier_object = nil

  def tier
    @tier_object = tiers.where('tier <= :value', value: chief_building.tier).order(tier: :desc).first if @tier_object.nil?
    @tier_object
  end

  def name
    gather_building.building.name
  end

  def resource
    gather_building.resource
  end

  def tiers
    gather_building.tiers
  end

  def rpm
    tier.rpm
  end

  def capacity
    tier.capacity
  end

  def update_quantity
    time = Time.now.to_time.to_f - last_update.to_time.to_f

    rpm = tier.rpm
    (1..chief_building.level - 1).each do
      rpm *= (1 + tier.increase)
    end
    add_quantity = tier.rpm * time / 60
    return if add_quantity < 1

    self.quantity += add_quantity
    self.quantity = tier.capacity if quantity > tier.capacity
    self.quantity = quantity.round unless quantity > tier.capacity

    self.last_update = Time.now
    save
  end

  def collect
    collect_quantity = self.quantity
    self.quantity = 0
    save
    chief_building.chief.gather_resource_of resource.name, collect_quantity
  end

end