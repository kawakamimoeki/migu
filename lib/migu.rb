# frozen_string_literal: true

require_relative "migu/version"
require_relative "migu/migration"
require_relative "migu/migrator"
require_relative "migu/state"
require_relative "migu/generator"

Dir['migu/migrate/*.rb'].each do |file|
  load file
end

module Migu
  class Error < StandardError; end
  # Your code goes here...

  def self.generate_config
    Dir.mkdir("migu") unless Dir.exist?("migu")
    filepath = "migu/config.rb"
    File.open(filepath, "w") do |file|
      file.write(<<-EOS)
Migu.configuration do |config|
  config.before do
    # before hook
  end

  config.after do
    # after hook
  end
end
      EOS
    end
  end

  def self.configuration(&block)
    @configuration ||= Configuration.new
    block.call(@configuration) if block_given?
    @configuration
  end

  class Configuration
    attr_accessor :before_hook, :after_hook

    def initialize
    end

    def before(&block)
      @before_hook = block
    end

    def after(&block)
      @after_hook = block
    end
  end
end

load "migu/config.rb" if File.exist?("migu/config.rb")