require 'fs_guy/version'
require 'fs_guy/engine'

module FsGuy
  class Error < StandardError; end

  def self.run(root = '.', &block)
    raise 'No block given' unless block_given?

    engine = FsGuy::Engine.new(root)
    engine.instance_eval(&block)
  end
end
