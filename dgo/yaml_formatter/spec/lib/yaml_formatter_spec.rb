# spec/lib/meta_information_spec.rb
require './lib/yaml_formatter'
require 'fileutils'

RSpec.describe 'YamlFormatter' do

  let(:original_file) { 'spec/fixtures/translations_simple.yml' }
  let(:created_file) { 'spec/fixtures/tmp/translations.yml' }
  let(:expected_file) { 'spec/fixtures/translations.yml' }

  after do
    if File.exist?(created_file)
      File.delete(created_file)
    end
  end

  describe '#convert' do
    it 'create valid yaml file' do
      expect {
        YamlFormatter.convert( original_file, created_file)
      }.to change {
        Dir[File.join('spec/fixtures/tmp', '**', '*')].count { |file| File.file?(file) }
      }.from(0).to(1)

      expect(
        FileUtils.compare_file( created_file, expected_file)
      ).to be_truthy
    end
  end
end
