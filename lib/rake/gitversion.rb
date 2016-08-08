require 'rake/gitversion/version'

module Rake
  module Gitversion
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
  end
end
