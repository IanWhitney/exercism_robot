require 'set'
class Robot
  def self.assigned_names
    @@assigned_names ||= Set.new
  end

  def name
    @name ||= generate_name
  end

  def reset
    self.name = nil
  end

  private

  attr_writer :name

  def new_name
    ('A'..'Z').to_a.sample(2).join + rand.to_s[2,3]
  end

  def generate_name
    temp_name = new_name
    until self.class.assigned_names.add?(temp_name)
      temp_name = new_name
    end
    temp_name
  end
end
