lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fs_guy/version'

Gem::Specification.new do |spec|
  spec.name          = 'fs_guy'
  spec.version       = FsGuy::VERSION
  spec.authors       = ['Egor Romanov']
  spec.email         = ['unsaidxpl@gmail.com']

  spec.summary       = 'A simple DSL for managing file system'
  spec.description   = 'A simple DSL for managing file system'
  spec.homepage      = 'https://github.com/fixtheclouds/fs_guy'
  spec.license       = 'MIT'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/fixtheclouds/fs_guy'
  spec.metadata['changelog_uri'] = 'https://github.com/fixtheclouds/fs_guy'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('lib', __dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4.0'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'fakefs', '~> 1.2.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.89.1'
  spec.add_development_dependency 'simplecov', '~> 0.19.1'
end
