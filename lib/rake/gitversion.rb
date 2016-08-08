require 'rake'
require 'rake/tasklib'
require 'rake/gitversion/version'
require 'bundler'

module Rake
  module Gitversion
    extend Rake::DSL if defined? Rake::DSL

    # Path to VERSION file
    VERSION_FILE_PATH = 'VERSION'.freeze # Todo: ensure correct directory

    # Get version from git via 'git describe'.
    # Requires annotated git tags in format 'v<MAJOR>.<MINOR>' like 'v4.11'
    # @param git_desc [String] output from 'git describe --long --dirty=-dirty'
    def self.version_from_git(git_desc = nil)
      if git_desc.nil?
        git_desc = `git describe --long --dirty=-dirty`
        if git_desc.empty?
          raise("ERROR: git describe failed. Make sure you are in git and" +
                  " there are annotated version tags like v0.1.")
        end
      end
      match = git_desc.match(/v(\d+)\.(\d+)-(\d+)-\w+(-dirty)?/)
      raise "'#{git_desc}' has invalid format" unless match
      patchlevel = match[4] ? "#{match[3].to_i + 1}.dev" : match[3]
      "#{match[1]}.#{match[2]}.#{patchlevel}"
    end

    # Create Rake task 'set_version' which writes generated
    # version string to VERSION file.
    def self.install_rake_tasks
      desc('Get version from git and save to VERSION file')
      task(:set_version) do
        version = version_from_git
        path = VERSION_FILE_PATH

        begin
          File.open(path, 'w') do |file|
            file.write(version)
          end
        rescue StandardError => error
          pp error
          raise("File #{path} unwritable.")
        end
      end
    end
  end
end

::Rake::Gitversion.install_rake_tasks
