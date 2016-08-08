$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rake/gitversion'

require 'minitest/autorun'
require 'minitest/reporters'
require 'mocha/mini_test'

MiniTest::Reporters.use!
