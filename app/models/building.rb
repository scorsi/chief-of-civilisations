
class Building < ApplicationRecord

  has_many :building_tiers
  has_many :gather_buildings

  has_many :chief_buildings

  alias_attribute :tiers, :building_tiers
  alias_attribute :gather_infos, :gather_buildings

  def gather?
    gather_infos.any?
  end

end