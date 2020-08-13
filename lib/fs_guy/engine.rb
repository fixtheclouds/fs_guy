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

    def file(name)
      @context = FileContext.new(full_path(name))
    end

    def move(new_path)
      @context = FileContext.new(full_path(new_path), :move)
    end

    def copy(new_path)
      @context = FileContext.new(full_path(new_path), :copy)
    end

    private

    def full_path(name)
      [path, name].join('/')
    end
  end
end
