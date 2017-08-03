
class ChiefResource < ApplicationRecord

  belongs_to :chief
  belongs_to :resource

  def self.create_from_starters(chief)
    starter_resources = StarterResource.all
    starter_resources.each do |starter_resource|
      ChiefResource.create chief: chief,
                           resource: starter_resource.resource,
                           quantity: starter_resource.quantity
    end
  end

  def name
    resource.name
  end

end