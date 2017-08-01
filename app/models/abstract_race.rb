class AbstractRace < ApplicationRecord

  belongs_to :main

  has_many :abstract_planets, through: :abstract_race_planets

  def self.find_by_main_name (name)
    main = Main.find_by_name name
    return nil if main.nil?
    AbstractRace.find_by_main_id main.id
  end

  def name
    main.name.capitalize
  end

  def description
    main.description
  end

end
