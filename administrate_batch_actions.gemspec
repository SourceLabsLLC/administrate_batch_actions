require_relative 'lib/administrate_batch_actions/version'

Gem::Specification.new do |spec|
  spec.name          = 'administrate_batch_actions'
  spec.version       = AdministrateBatchActions::VERSION
  spec.authors       = ['Sourcelabs LLC']
  spec.email         = ['andrei@sourcelabs.io']
  spec.homepage      = 'https://github.com/SourceLabsLLC/administrate_batch_actions'
  spec.summary       = 'Batch Actions plugin for Administrate'
  spec.description   = 'Adds checkboxes, a "select all" checkbox and batch action buttons to Administrate index pages.'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.2'

  spec.metadata = {
    'source_code_uri' => spec.homepage,
    'changelog_uri' => "#{spec.homepage}/blob/main/CHANGELOG.md",
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir['{app,config,lib}/**/*', 'CHANGELOG.md', 'LICENSE.txt', 'README.md']
  spec.require_paths = ['lib']

  spec.add_dependency 'administrate', '>= 1.0'
  spec.add_dependency 'rails', '>= 7.1'
end
