class Robot
  def name
    @name ||= (('a'..'z').to_a + ('A'..'Z').to_a).sample(2).join + rand.to_s[2,3]
  end

  def reset
    self.name = nil
  end

  private

  attr_writer :name
end
