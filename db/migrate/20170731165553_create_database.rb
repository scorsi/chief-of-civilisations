class CreateDatabase < ActiveRecord::Migration[5.1]
  def change


    ## Main
    #  ----
    #  The main table which contains a name and a description for each things in the game
    #  The name is unique because everything must be unique!
    create_table :mains do |t|
      t.string :name
      t.text :description
    end
    add_index :mains, :name, unique: true


    #######################
    ### Abstract Models ###
    #######################


    # The abstracts models permits to create new available models in game
    # They're like config models


    ## Abstract Primary Resource
    #  -----------------
    #  The primary resources which can be gathered
    create_table :abstract_primary_resources do |t|
      t.references :main, foreign_key: true
    end

    ## Abstract Technology
    #  ------------
    #  The technologies permits to discover and evolve the population
    create_table :abstract_technologies do |t|
      t.references :main, foreign_key: true

      t.boolean :special
    end

    ## Abstract Building
    #  ---------
    #  The buildings are the main part of the game, it permits to craft resources, build buildings, learn technologies...
    create_table :abstract_buildings do |t|
      t.references :main, foreign_key: true

      t.integer :maximum
      t.boolean :special
    end

    ## Abstract Unit
    #  -----
    #  The units are very important, each type of units can do different and unique things
    create_table :abstract_units do |t|
      t.references :main, foreign_key: true

      t.integer :maximum
      t.boolean :special
    end


    ####################################
    ### Available config for Players ###
    ####################################


    ## Abstract Planet
    #  -------
    #  The planets represents the ground of the population
    #  A player can have more than one planet later in the game
    create_table :abstract_planets do |t|
      t.references :main, foreign_key: true
    end

    ## Abstract Race
    #  -----
    #  The races give extra bonuses for everything, it must be well chosen
    create_table :abstract_races do |t|
      t.references :main, foreign_key: true
    end

    ## Abstract Race Planet
    #  --------------------
    #  Races has only few available planets at the beginning
    create_table :abstract_race_planets do |t|
      t.references :abstract_race, foreign_key: true
      t.references :abstract_planet, foreign_key: true
    end

    ## Abstract Race Technology
    #  ------------------------
    #  Races has special technologies
    create_table :abstract_race_technologies do |t|
      t.references :abstract_race, foreign_key: true
      t.references :abstract_technology, foreign_key: true
    end

    ## Abstract Race Building
    #  ----------------------
    #  Races has special buildings
    create_table :abstract_race_buildings do |t|
      t.references :abstract_race, foreign_key: true
      t.references :abstract_building, foreign_key: true
    end

    ## Abstract Race Units
    #  -------------------
    #  Races has special units
    create_table :abstract_race_units do |t|
      t.references :abstract_race, foreign_key: true
      t.references :abstract_unit, foreign_key: true
    end


    #########################
    ## All Available Tiers ##
    #########################


    ## Abstract Building Tier
    #  ---------
    #  The tier available for a given building
    create_table :abstract_building_tiers do |t|
      t.references :abstract_building, foreign_key: true

      t.integer :number
    end

    ## Abstract Technology Tier
    #  ---------
    #  The tier available for a given building
    create_table :abstract_technology_tiers do |t|
      t.references :abstract_technology, foreign_key: true

      t.integer :number
    end

    ## Abstract Unit Tier
    #  ---------
    #  The tier available for a given building
    create_table :abstract_unit_tiers do |t|
      t.references :abstract_unit, foreign_key: true

      t.integer :number
    end


    ##################################
    ### Needed resources for Tiers ###
    ##################################


    ## Building Tiers

    create_table :abstract_building_tier_primary_resources do |t|
      t.references :abstract_building_tier, foreign_key: true, index: {name: 'idx_abstract_buildings_tier_parent_primary_resource'}
      t.references :abstract_primary_resource, foreign_key: true, index: {name: 'idx_abstract_buildings_tier_primary_resource'}

      t.integer :number
    end
    add_index :abstract_building_tier_primary_resources, [:abstract_building_tier_id, :abstract_primary_resource_id], unique: true, name: 'idx_abstract_building_tier_primary_resources_unique'

    create_table :abstract_building_tier_technologies do |t|
      t.references :abstract_building_tier, foreign_key: true, index: {name: 'idx_abstract_buildings_tier_parent_technology'}
      t.references :abstract_technology, foreign_key: true, index: {name: 'idx_abstract_buildings_tier_technology'}

      t.integer :number
    end
    add_index :abstract_building_tier_technologies, [:abstract_building_tier_id, :abstract_technology_id], unique: true, name: 'idx_abstract_building_tier_technologies_unique'

    create_table :abstract_building_tier_buildings do |t|
      t.references :abstract_building_tier, foreign_key: true, index: {name: 'idx_abstract_buildings_tier_parent_building'}
      t.references :abstract_building, foreign_key: true, index: {name: 'idx_abstract_buildings_tier_building'}

      t.integer :number
    end
    add_index :abstract_building_tier_buildings, [:abstract_building_tier_id, :abstract_building_id], unique: true, name: 'idx_abstract_building_tier_buildings_unique'

    ## Technology Tiers

    create_table :abstract_technology_tier_primary_resources do |t|
      t.references :abstract_technology_tier, foreign_key: true, index: {name: 'idx_abstract_technology_tier_parent_primary_resource'}
      t.references :abstract_primary_resource, foreign_key: true, index: {name: 'idx_abstract_technology_tier_primary_resource'}

      t.integer :number
    end
    add_index :abstract_technology_tier_primary_resources, [:abstract_technology_tier_id, :abstract_primary_resource_id], unique: true, name: 'idx_abstract_technology_tier_primary_resources_unique'

    create_table :abstract_technology_tier_technologies do |t|
      t.references :abstract_technology_tier, foreign_key: true, index: {name: 'idx_abstract_technology_tier_parent_technology'}
      t.references :abstract_technology, foreign_key: true, index: {name: 'idx_abstract_technology_tier_technology'}

      t.integer :number
    end
    add_index :abstract_technology_tier_technologies, [:abstract_technology_tier_id, :abstract_technology_id], unique: true, name: 'idx_abstract_technology_tier_technologies_unique'

    create_table :abstract_technology_tier_buildings do |t|
      t.references :abstract_technology_tier, foreign_key: true, index: {name: 'idx_abstract_technology_tier_parent_building'}
      t.references :abstract_building, foreign_key: true, index: {name: 'idx_abstract_technology_tier_building'}

      t.integer :number
    end
    add_index :abstract_technology_tier_buildings, [:abstract_technology_tier_id, :abstract_building_id], unique: true, name: 'idx_abstract_technology_tier_buildings_unique'

    ## Unit Tiers

    create_table :abstract_unit_tier_primary_resources do |t|
      t.references :abstract_unit_tier, foreign_key: true, index: {name: 'idx_abstract_units_tier_parent_primary_resource'}
      t.references :abstract_primary_resource, foreign_key: true, index: {name: 'idx_abstract_units_tier_primary_resource'}

      t.integer :number
    end
    add_index :abstract_unit_tier_primary_resources, [:abstract_unit_tier_id, :abstract_primary_resource_id], unique: true, name: 'idx_abstract_unit_tier_primary_resources_unique'

    create_table :abstract_unit_tier_technologies do |t|
      t.references :abstract_unit_tier, foreign_key: true, index: {name: 'idx_abstract_units_tier_parent_technology'}
      t.references :abstract_technology, foreign_key: true, index: {name: 'idx_abstract_units_tier_technology'}

      t.integer :number
    end
    add_index :abstract_unit_tier_technologies, [:abstract_unit_tier_id, :abstract_technology_id], unique: true, name: 'idx_abstract_unit_tier_technologies_unique'

    create_table :abstract_unit_tier_buildings do |t|
      t.references :abstract_unit_tier, foreign_key: true, index: {name: 'idx_abstract_units_tier_parent_building'}
      t.references :abstract_building, foreign_key: true, index: {name: 'idx_abstract_units_tier_building'}

      t.integer :number
    end
    add_index :abstract_unit_tier_buildings, [:abstract_unit_tier_id, :abstract_building_id], unique: true, name: 'idx_abstract_unit_tier_buildings_unique'


    ######################
    ### Players Models ###
    ######################


    ## Race
    create_table :races do |t|
      t.references :abstract_race, foreign_key: 'abstract_race'
    end

    ## Player
    create_table :players do |t|
      t.references :race, foreign_key: 'race'
      t.references :user, foreign_key: 'user'

      t.boolean :is_alive, default: false
    end

    ## Planet
    create_table :planets do |t|
      t.references :abstract_planet, foreign_key: 'abstract_planet'
      t.references :player, foreign_key: 'player'
    end

    ## Primary Resource
    create_table :primary_resources do |t|
      t.references :abstract_primary_resource, foreign_key: 'abstract_primary_resource'
      t.references :planet, foreign_key: 'planet'

      t.integer :number
    end

    ## Technology
    create_table :technologies do |t|
      t.references :abstract_technology, foreign_key: 'abstract_technology'
      t.references :player, foreign_key: 'player'

      t.integer :tier
    end

    ## Building
    create_table :buildings do |t|
      t.references :abstract_building, foreign_key: 'abstract_building'
      t.references :planet, foreign_key: 'planet'

      t.integer :tier
    end

    ## Unit
    create_table :units do |t|
      t.references :abstract_unit, foreign_key: 'abstract_unit'
      t.references :planet, foreign_key: 'planet'

      t.integer :tier
      t.integer :number
    end



    ### New features

    ## Craft
    #create_table :crafts do |t|
    #  t.belongs_to :abstract_crafts, foreign_key: 'abstract_craft'
    #end

    ## Abstract Craft
    #  ------
    #  The crafts are resources which can be manufactured thanks to the primary resources
    #  It's needed to build buildings or units
    #create_table :abstract_crafts do |t|
    #  t.belongs_to :mains, foreign_key: 'main'
    #end
  end
end
