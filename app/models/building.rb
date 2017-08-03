
class Building < ApplicationRecord

  belongs_to :main
  belongs_to :resource, optional: true
  has_many :building_tiers
  has_many :gather_buildings

  alias_attribute :tiers, :building_tiers
  alias_attribute :gather_infos, :gather_buildings

  def self.find_by_main_name(name)
    main = Main.find_by_name(name)
    return nil if main.nil?
    Building.find_by_main_id(main.id)
  end

  def gather?
    gather_infos.any?
  end

  def name
    main.name
  end

  def description
    main.description
  end

end