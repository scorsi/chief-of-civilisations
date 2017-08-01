class Planet < ApplicationRecord

  belongs_to :abstract_planet
  belongs_to :player

  has_many :buildings
  has_many :primary_resources
  has_many :units

end
