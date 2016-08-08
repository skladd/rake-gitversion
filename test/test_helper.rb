require 'minitest/autorun'
require 'minitest/reporters'
require 'mocha/mini_test'

MiniTest::Reporters.use!

# Fake Rakefile methods
module Rake
  module Gitversion
    def self.desc(text)
      $desc_text = text
    end

    def self.task(name, &block)
      $task_name = name
      $task_block = block
    end
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rake/gitversion'
