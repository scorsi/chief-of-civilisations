
class Chief < ApplicationRecord

  belongs_to :user

  has_many :chief_buildings, dependent: :destroy
  has_many :chief_resources, dependent: :destroy

  alias_attribute :buildings, :chief_buildings
  alias_attribute :resources, :chief_resources

  def resource_of(name)
    resources.each do |resource|
      return resource if resource.name == name
    end
    nil
  end

  def use_resource_of(name, quantity)
    resource = resource_of name
    return if resource.nil?
    resource.quantity -= quantity
    resource.save
  end

  def gather_resource_of(name, quantity)
    resource = resource_of name
    if resource.nil?
      resource = ChiefResource.new
      resource.chief = self
      resource.resource = Resource.find_by_main_name name
      resource.quantity = 0
    end
    resource.quantity += quantity
    resource.save
  end

  def quantity_of(name)
    resource = resource_of name
    return 0 if resource.nil?
    resource.quantity
  end

end