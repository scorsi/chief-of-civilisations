class PrimaryResource < ApplicationRecord

  belongs_to :abstract_primary_resource
  belongs_to :planet

end
