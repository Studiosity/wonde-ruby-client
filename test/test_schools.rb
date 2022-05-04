require 'wondeclient'
require 'minitest/autorun'
class WondeTest < Minitest::Test
  def test_returns_schools
    array_of_schools = @@client.schools.all
    assert array_of_schools.instance_of?(Array) && array_of_schools.length > 0
  end
end
