#############
### Seeds ###
#############


## Functions


def create_main (name, description)
  Main.create name: name, description: description
end

def create_primary_resources (primary_resource)
  main = create_main primary_resource[0], primary_resource[1]
  AbstractPrimaryResource.create main: main
end

def create_building (building)
  main = create_main building[0], building[1]
  AbstractBuilding.create main: main, maximum: building[2], special: building[3]
end

def create_building_tier (building_tier)
  building = AbstractBuilding.find_by_main_name building_tier[0]
  if building != nil
    tier = AbstractBuildingTier.create abstract_building: building, number: building_tier[1]
    building_tier[2].each do |require_primary_resource|
      r_primary_resource = AbstractPrimaryResource.find_by_main_name require_primary_resource[0]
      AbstractBuildingTierPrimaryResource.create abstract_building_tier: tier, abstract_primary_resource: r_primary_resource, number: require_primary_resource[1]
    end
    building_tier[3].each do |require_building|
      r_building = AbstractBuilding.find_by_main_name require_building[0]
      AbstractBuildingTierBuilding.create abstract_building_tier: tier, abstract_building: r_building, number: require_building[1]
    end
    building_tier[4].each do |require_technology|
      r_technology = AbstractTechnology.find_by_main_name require_technology[0]
      AbstractBuildingTierTechnology.create abstract_building_tier: tier, abstract_technology: r_technology, number: require_technology[1]
    end
  end
end

def create_technology (technology)
  main = create_main technology[0], technology[1]
  AbstractTechnology.create main: main, special: technology[2]
end


## Data


### PRIMARY RESOURCES

primary_resources = [['wood', 'One of the first resource'],
                     ['steel', 'At its discovering, the population has evolve faster']]
primary_resources.each do |primary_resource|
  create_primary_resources primary_resource
end

### BUILDINGS

buildings = [['citadel', 'The main building', 1, false],
             ['barrack', 'The building to train your army', 1, false]]
buildings.each do |building|
  create_building building
end

### TECHNOLOGIES

technologies = [['exploration', 'The exploration permits to discover many new technologies, new cultures and new populations', false]]
technologies.each do |technology|
  create_technology technology
end

### BUILDING TIERS

building_tiers = [['citadel', 1,
                   [['wood', 10]],
                   [],
                   []],
                  ['citadel', 2,
                   [['wood', 25], ['steel', 5]],
                   [['barrack', 1]],
                   []],
                  ['barrack', 1,
                   [['wood', 5]],
                   [['citadel', 1]],
                   []]]
building_tiers.each do |building_tier|
  create_building_tier building_tier
end
