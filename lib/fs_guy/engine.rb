require 'fs_guy/folder_context'
require 'fs_guy/file_context'

module FsGuy
  # Core class, responsible for dispatching method calls
  # to corresponding contexts
  class Engine
    attr_reader :root, :context

    FILE_METHODS = %i[move copy own mode].freeze
    INVALID_DIR_REGEX = /..\//

    def initialize(root)
      raise Error, 'Cannot operate in parent directory' if root =~ INVALID_DIR_REGEX

      @root = root
      @context = nil
    end

    def dir(name, &block)
      validate_path(name)
      @context = FolderContext.new(full_path(name))

      instance_eval(&block) if block_given?
    end

    def file(file_path)
      validate_path(file_path)
      @context = create_file_context(file_path)
    end

    # Use metaprogramming magic to call FileContext methods by default
    def method_missing(method, *args)
      validate_path(name)
      @context = create_file_context(file_path).send(method, *args)
    end

    # Allow correct behaviour for #respond_to?
    def respond_to_missing?(method_name)
      FILE_METHODS.include?(method_name) || super
    end

    private

    def create_file_context(file_path)
      FileContext.new(full_path(file_path))
    end

    def full_path(name)
      [root, name].join('/')
    end

    def validate_path(path)
      raise Error, 'Cannot operate in parent directory' if path =~ INVALID_DIR_REGEX
    end
  end
end
