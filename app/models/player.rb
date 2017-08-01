class Player < ApplicationRecord

  has_many :planets
  has_many :buildings, through: :planets
  has_many :primary_resources, through: :planets
  has_many :units, through: :planets

end
