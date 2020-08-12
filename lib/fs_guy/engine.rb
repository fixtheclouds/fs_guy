require 'fs_guy/folder_context'

module FsGuy
  class Engine
    attr_reader :path

    def initialize(root = '.')
      @path = root
    end

    def folder(name, &block)
      folder = FolderContext.new(full_path(name))
      @path = folder.path

      instance_eval(&block) if block_given?
    end

    def file(name)
      FileUtils.touch(full_path(name))
    end

    private

    def full_path(name)
      [path, name].join('/')
    end
  end
end
