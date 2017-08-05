
class Building < ApplicationRecord

  has_many :building_tiers
  has_many :gather_buildings

  has_many :chief_buildings

  alias_attribute :tiers, :building_tiers
  alias_attribute :gather_infos, :gather_buildings

  def gather?
    gather_infos.any?
  end

  def construct?(chief)
    construct_resources.each do |resource|
      return false if chief.quantity_of(resource.name) < resource.quantity
    end
    true
  end

  def construct(chief)
    return unless construct? chief
    construct_resources.each { |resource| chief.use_resource_of resource.name, resource.quantity }
    ChiefBuilding.create chief: chief, building: self
  end

  private

  @resources = nil

  def construct_resources
    @resources = tiers.find_by_tier(1).resources if @resources.nil?
    @resources
  end

end