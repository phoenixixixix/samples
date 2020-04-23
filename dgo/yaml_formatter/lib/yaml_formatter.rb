require "active_support/core_ext/hash"
require "yaml_formatter/version"
require 'yaml'

module YamlFormatter

  # Example:
  # YamlFormatter.convert('../translations_simple.yml', '../translations.yml')
  class << self
    def convert(source, destination)

      simple_yml = ::YAML.load_file(source)

      yml = {}
      simple_yml.each do |key, value|
        yml.deep_merge! key.split('.').reverse.inject(value) { |a, n| { n => a } }
      end

      File.open(destination, "w+") { |file| file.write(yml.to_yaml) }
    end
  end
end
