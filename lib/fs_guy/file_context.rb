require 'fileutils'

module FsGuy
  class FileContext
    attr_accessor :path, :operation

    def initialize(path, operation = nil)
      @path = path
      @operation = operation
      create unless operation
    end

    def to(new_path)
      raise FsGuy::Error, 'Target file must be provided' unless path

      case operation.to_sym
      when :move
        FileUtils.mv(path, new_path)
      when :copy
        FileUtils.cp(path, new_path)
      else
        raise FsGuy::Error, 'Method must be specified'
      end

      self
    end

    private

    def create
      FileUtils.touch(path)
    end
  end
end
