#############
### Seeds ###
#############

def create_resource(name, description)
  Resource.create name: name, description: description
end

def create_building(name, description)
  Building.create name: name, description: description
end

def create_building_tier(name, tier, require_resources)
  building = Building.find_by_name name
  return if building.nil?
  building_tier = BuildingTier.create building: building, tier: tier
  require_resources.each do |require_resource|
    resource = Resource.find_by_name require_resource[0]
    next if resource.nil?
    BuildingTierResource.create building_tier: building_tier, resource: resource,
                                quantity: require_resource[1], increase: require_resource[2]
  end
end

def create_gather_building(building_name, resource_name)
  resource = Resource.find_by_name resource_name
  building = Building.find_by_name building_name
  return if building.nil? or resource.nil?
  GatherBuilding.create building: building, resource: resource
end

# TODO: ADD GATHER BUILDING TIER ON BUILDING __AND RESOURCE__!
def create_gather_building_tier(building_name, resource_name, tier, capacity, rpm, increase)
  gather_building = GatherBuilding.building_name(building_name).resource_name(resource_name).first
  return if gather_building.nil?
  GatherBuildingTier.create gather_building: gather_building, tier: tier,
                            rpm: rpm, increase: increase, capacity: capacity
end

def create_starter_resource(name, quantity)
  resource = Resource.find_by_name name
  StarterResource.create resource: resource, quantity: quantity unless resource.nil?
end

def create_starter_building(name)
  building = Building.find_by_name name
  StarterBuilding.create building: building unless building.nil?
end

######################################################################

### RESOURCES

create_resource 'wood', 'One of the primary resource'
create_resource 'steel', 'At its discovering, the population has evolved faster'
create_resource 'food', 'The food is vital'

### BUILDINGS

# Citadel
create_building 'citadel', 'The main building'
# Barrack
create_building 'barrack', 'The building to train your army'
# Lumberyard
create_building 'lumberyard', 'The lumberjack give all the needed wood to the Citadel'
create_gather_building 'lumberyard', 'wood'
# Farm
create_building 'farm', 'The farm give all the require food to the population'
create_gather_building 'farm', 'food'
# Extra collect building
create_building 'extra collect building', 'A cheated building'
create_gather_building 'extra collect building', 'food'
create_gather_building 'extra collect building', 'steel'
create_gather_building 'extra collect building', 'wood'

### TIERS

# Citadel
create_building_tier 'citadel', 1, [['wood', 100, 0.2]]
create_building_tier 'citadel', 2, [['wood', 500, 0.3], ['food', 200, 0.1]]
# Barrack
create_building_tier 'barrack', 1, [['wood', 200, 0.15]]
# Lumberyard
create_building_tier 'lumberyard', 1, [['wood', 50, 0.1]]
create_building_tier 'lumberyard', 2, [['wood', 350, 0.1]]
create_gather_building_tier 'lumberyard', 'wood', 1, 100, 10, 0.05
create_gather_building_tier 'lumberyard', 'wood', 2, 650, 30, 0.05
# Farm
create_building_tier 'farm', 1, [['wood', 50, 0.1]]
create_building_tier 'farm', 2, [['wood', 250, 0.1]]
create_gather_building_tier 'farm', 'food', 1, 100, 10, 0.05
# Extra collect building
create_building_tier 'extra collect building', 1, []
create_gather_building_tier 'extra collect building', 'food', 1, 1000, 100, 0
create_gather_building_tier 'extra collect building', 'wood', 1, 1000, 100, 0
create_gather_building_tier 'extra collect building', 'steel', 1, 1000, 100, 0

### STARTERS

create_starter_resource 'wood', 100
create_starter_building 'lumberyard'
create_starter_building 'extra collect building'
