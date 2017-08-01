class Building < ApplicationRecord

  belongs_to :abstract_building
  belongs_to :planet

end
