
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yaml_formatter/version"

Gem::Specification.new do |spec|
  spec.name          = "yaml_formatter"
  spec.version       = YamlFormatter::VERSION
  spec.authors       = ["Dmitry Gorodnichy"]
  spec.email         = ["gorodni4ij@gmail.com"]

  spec.summary       = %q{YAML file prettifier}
  spec.description   = %q{Transform the translations from simple format into a YAML file that can be used in the rails application.}
  spec.homepage      = "https://github.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'bundler', '~> 1.16'
  spec.add_dependency 'activesupport', '~> 5.1', '>= 5.1.4'

  spec.add_development_dependency 'rspec', '~> 3.8.0'
end
