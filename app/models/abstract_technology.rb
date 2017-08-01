class AbstractTechnology < ApplicationRecord

  belongs_to :main

  has_many :abstract_technology_tiers

  def tiers
    abstract_technology_tiers
  end

  def self.find_by_main_name (name)
    main = Main.find_by_name name
    return nil if main.nil?
    AbstractTechnology.find_by_main_id main.id
  end

  def name
    main.name.capitalize
  end

  def description
    main.description
  end

end
