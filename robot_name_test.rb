require 'minitest/autorun'
require_relative 'robot'

class RobotTest < MiniTest::Unit::TestCase
  def teardown
    NamePersistence.clear!
  end

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

  def test_name_is_added_to_persistence
    @persistence = MiniTest::Mock.new
    @persistence.expect :add, true, [NameGenerator]
    Robot.new(persistence: @persistence).name
    assert @persistence.verify
  end

  def test_name_is_created_by_namegenerator
    @generator = MiniTest::Mock.new
    @generator.expect :build, "AB123"
    robot = Robot.new(generator: @generator)
    assert_equal "AB123", robot.name
    assert @generator.verify
  end

  def test_names_are_unique
    @generator = NameGeneratorDouble
    robot = Robot.new(generator: @generator)
    assert_equal "AB123", robot.name

    robot = Robot.new(generator: @generator)
    assert_equal "ZZ789", robot.name
  end
end

class NameGeneratorDouble
  @@names = %w(AB123 AB123 ZZ789)
  def self.build
    @@names.shift
  end
end

class NamePersistenceTest < MiniTest::Test
  def teardown
    NamePersistence.clear!
  end

  def test_adding_returns_a_non_nil
    name = "test"
    assert NamePersistence.add(name)
  end

  def test_adding_something_already_added_returns_nil
    name = "test"
    NamePersistence.add(name)
    assert_nil NamePersistence.add(name)
  end
end

class NameGeneratorTest < MiniTest::Test
  def test_build_returns_a_robot_name_string
    name = NameGenerator.build
    assert_match /^[A-Z]{2}\d{3}$/, name
  end
end
