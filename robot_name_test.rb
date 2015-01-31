require 'minitest/autorun'
require_relative 'robot'

class RobotTest < MiniTest::Unit::TestCase
  def test_has_name
    assert_match /^[A-Z]{2}\d{3}$/, Robot.new.name
  end

  def test_name_sticks
    robot = Robot.new
    robot.name
    assert_equal robot.name, robot.name
  end

  def test_different_robots_have_different_names
    assert Robot.new.name != Robot.new.name
  end

  def test_reset_name
    robot = Robot.new
    name = robot.name
    robot.reset
    name2 = robot.name
    assert name != name2
    assert_match /^[A-Z]{2}\d{3}$/, name2
  end
end

class NamePersistenceTest < MiniTest::Unit::TestCase
  def test_add
    name = "test"
    assert NamePersistence.add(name)
    assert_nil NamePersistence.add(name)
  end
end
