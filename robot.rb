class Robot

  def initialize(persistence = NamePersistence)
    self.persistence = persistence
  end

  def name
    @name ||= generate_name
  end

  def reset
    self.name = nil
  end

  private

  attr_writer :name
  attr_accessor :persistence

  def new_name
    ('A'..'Z').to_a.sample(2).join + rand.to_s[2,3]
  end

  def generate_name
    temp_name = new_name
    until persistence.add(temp_name)
      temp_name = new_name
    end
    temp_name
  end
end

require 'set'
class NamePersistence
  def self.add(name)
    collection.add?(name)
  end

  def self.clear!
    @@collection = nil
  end

  private

  def self.collection
    @@collection ||= Set.new
  end
end

