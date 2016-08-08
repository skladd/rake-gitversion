require 'test_helper'

class GitversionTest < Minitest::Test
  RG = ::Rake::Gitversion

  def test_version_from_git
    assert_equal('0.5.0', RG.version_from_git('v0.5-0-gb345511'))
    assert_equal('0.5.1.dev', RG.version_from_git('v0.5-0-gb345511-dirty'))
    assert_equal('1.7.32', RG.version_from_git('v1.7-32-abcd1234'))
    assert_raises(RuntimeError) { RG.version_from_git('wrongtag-deadbeef') }
    assert_raises(RuntimeError) { RG.version_from_git('v0.4.0-0-0a1b2c3d') }

    # current git project should work as well
    RG.expects(:`).returns('v1.2-0-1331baff')
    assert_equal('1.2.0', RG.version_from_git)
  end

  def test_rake_task_installed
    assert_kind_of(String, $desc_text)
    assert_equal(:set_version, $task_name)
    assert_kind_of(Proc, $task_block)
  end

  def test_set_version_task
    RG.expects(:version_from_git).returns('BestVersionEver')
    file_handle = mock
    file_handle.stubs(:write).with('BestVersionEver').once
    File.stubs(:open).with('VERSION', 'w').yields(file_handle).once
    $task_block.call
  end
end
