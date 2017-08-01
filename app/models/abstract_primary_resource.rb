class AbstractPrimaryResource < ApplicationRecord

  belongs_to :main

  def self.find_by_main_name(name)
    main = Main.find_by_name name
    return nil if main.nil?
    AbstractPrimaryResource.find_by_main_id main.id
  end

  def name
    main.name.capitalize
  end

  def description
    main.description
  end

end
