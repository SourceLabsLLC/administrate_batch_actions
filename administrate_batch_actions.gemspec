lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'administrate_batch_actions/version'

Gem::Specification.new do |spec|
  spec.name          = 'administrate_batch_actions'
  spec.version       = AdministrateBatchActions::VERSION
  spec.authors       = ['Sourcelabs LLC']
  spec.email         = ['andrei@sourcelabs.io']
  spec.homepage      = 'https://github.com/SourceLabsLLC/administrate-batch-actions'
  spec.summary       = 'Batch Actions plugin for Administrate'
  spec.description   = spec.summary
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_dependency 'administrate'
  spec.add_dependency 'rails', '>= 5.2'
end
