# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'rspec-steps'
  spec.version       = '3.0.0'
  spec.authors       = ['Judson Lester', 'Evan Dorn']
  spec.email         = ['judson@lrdesign.com', 'evan@lrdesign.com']

  spec.summary       = 'I want steps in RSpec'
  spec.description   = <<~DESCRIPTION
    A minimal implementation of integration testing within RSpec.
    Allows you to build sequential specs, each with a description,
    but where state is maintained between tests and before/after actions are only
    triggered at the beginning and end of the entire sequence.  Cool things you
    can do with this:

    * Build multi-step user stories in plain RSpec syntax. Locate the point of
      failure quickly, and break up large integrations into sensible steps
    * Speed up groups of related tests by running your factories only once before
      the whole group.
  DESCRIPTION

  spec.homepage      = 'https://github.com/LRDesign/rspec-steps'
  spec.license       = 'MIT'

  spec.files         = Dir[
    'lib/**/*',
    'doc/**/*',
    'spec/**/*',
    'spec_help/**/*',
  ]
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.1.0'

  spec.add_dependency 'rspec', '>= 3.0', '< 4'

  spec.rdoc_options = [
    '--inline-source',
    '--line-numbers',
    '--title', "#{spec.name}-#{spec.version} Documentation",
    '--main', 'doc/README',
    '--exclude', 'spec/*'
  ]
  spec.extra_rdoc_files = Dir.glob('doc/**/*')
end
