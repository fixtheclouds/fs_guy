require 'fs_guy/folder_context'
require 'fs_guy/file_context'

module FsGuy
  class Engine
    attr_reader :path, :context

    def initialize(root)
      @path = root
      @context = nil
    end

    def dir(name, &block)
      @context = FolderContext.new(full_path(name))
      @path = context.path

      instance_eval(&block) if block_given?
    end

    def file(file_path)
      @context = FileContext.new(full_path(file_path))
    end

    def move(file_path)
      @context = FileContext.new(full_path(file_path)).move
    end

    def copy(file_path)
      @context = FileContext.new(full_path(file_path)).copy
    end

    def own(file_path, owner)
      @context = FileContext.new(full_path(file_path)).own(owner)
    end

    def mode(file_path, key)
      @context = FileContext.new(full_path(file_path)).mode(key)
    end

    private

    def full_path(name)
      [path, name].join('/')
    end
  end
end
