require 'fileutils'

module FsGuy
  class FolderContext
    attr_reader :path

    def initialize(path)
      @path = path
      FileUtils.mkdir_p(path)
    end
  end
end
