
class Resource < ApplicationRecord

  belongs_to :main

  def self.find_by_main_name(name)
    main = Main.find_by_name(name)
    return nil if main.nil?
    Resource.find_by_main_id(main.id)
  end

  def name
    main.name
  end

  def description
    main.description
  end

end