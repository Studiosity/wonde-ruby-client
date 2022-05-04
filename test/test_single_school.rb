require 'wondeclient'
require 'minitest/autorun'
class WondeTest < Minitest::Test
  def test_single_school
    school = @@client.schools.get(@@SCHOOLID)
    assert !school.nil? && school.name.instance_of?(String)
  end
end
