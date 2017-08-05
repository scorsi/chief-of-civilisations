class CreateSchemes < ActiveRecord::Migration[5.1]
  def change

    ## Resources
    #  -----------------
    #  The resources can be gathered or created
    #
    create_table :resources do |t|
      t.string :name
      t.text :description
    end
    add_index :resources, :name, unique: true

    ## Buildings
    #  ---------
    #  The buildings are the main part of the game
    #  It permits to gather resources, build buildings, learn technologies...
    #
    create_table :buildings do |t|
      t.string :name
      t.text :description
      t.integer :maximum, default: 1
    end
    add_index :buildings, :name, unique: true

    ## Buildings Tiers
    #  ---------------
    #  The building tier informs of the needed resources at each tier
    #
    create_table :building_tiers do |t|
      t.references :building, foreign_key: true
      t.integer :tier
    end
    add_index :building_tiers, %i[building_id tier], unique: true

    ## Building Tier Resources
    #  ---------------------------------
    #  It informs the resources needed for the tier
    #
    create_table :building_tier_resources do |t|
      t.references :building_tier, foreign_key: true
      t.references :resource, foreign_key: true
      t.integer :quantity
      t.float :increase
    end
    add_index :building_tier_resources, %i[building_tier_id resource_id], unique: true, name: 'idx_building_tier_resources_unique'

    ## Gather Buildings
    #  ----------------
    #  The buildings which gather automatically resources
    #
    create_table :gather_buildings do |t|
      t.references :building, foreign_key: true
      t.references :resource, foreign_key: true
    end

    ## Gather Buildings Tiers
    #  ----------------------
    #  The gather buildings tier precise how many resources will be collected
    #  for each tier of the building
    #
    create_table :gather_building_tiers do |t|
      t.references :gather_building, foreign_key: true
      t.integer :tier
      t.integer :capacity
      t.integer :rpm # Resources per minutes
      t.float :increase # The increase of rps for each level of the building
    end
    add_index :gather_building_tiers, %i[gather_building_id tier], unique: true

    ## Chief
    #  -----
    #  The chief is attached to an user
    #
    create_table :chiefs do |t|
      t.references :user, foreign_key: true
    end

    ## Chief Buildings
    #  ---------------
    #  All the buildings of a chief
    #
    create_table :chief_buildings do |t|
      t.references :chief, foreign_key: true
      t.references :building, foreign_key: true
      t.integer :level, default: 1
      t.integer :tier, default: 1
    end

    ## Chief Gather Buildings
    #  ---------------
    #  All the buildings of a chief
    #
    create_table :chief_gather_buildings do |t|
      t.references :chief_building, foreign_key: true
      t.references :gather_building, foreign_key: true
      t.datetime :last_update, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :quantity, default: 0
    end

    ## Chief Resources
    #  ---------------
    #  All the resources of a chief
    #
    create_table :chief_resources do |t|
      t.references :chief, foreign_key: true
      t.references :resource, foreign_key: true
      t.integer :quantity
    end

    ## Starter Resources
    #  -----------------
    #  The resources of a chief at the beginning
    #
    create_table :starter_resources do |t|
      t.references :resource, foreign_key: true
      t.integer :quantity
    end

    ## Starter Buildings
    #  -----------------
    #  The buildings of a chief at the beginning
    #
    create_table :starter_buildings do |t|
      t.references :building, foreign_key: true
    end
  end
end
