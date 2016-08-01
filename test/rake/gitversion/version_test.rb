require 'test_helper'

class Rake::VersionTest < Minitest::Test
  def test_own_version_number
    refute_nil(::Rake::Gitversion::VERSION)
    version_regex = /^\d+\.\d+\.\d+(\.\w+)?$/
    assert_match(version_regex, ::Rake::Gitversion::VERSION)
  end
end
