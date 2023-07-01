require "active_support/inflector"

module Migu
  class Generator
    attr_reader :path

    def initialize
      @path = "migu/migrate"
    end

    def generate(name)
      time = Time.now
      filename = "#{time.strftime("%Y%m%d%H%M%S")}_#{name}.rb"
      filepath = File.join(path, filename)
      Dir.mkdir(path) unless Dir.exist?(path)
      File.open(filepath, "w") do |file|
        file.write(<<-EOS)
class #{name.camelize} < Migu::Migration
  def self.time
    "#{time.to_s}"
  end

  def up
  end

  def down
  end
end
EOS

        return filepath
      end
    end

    def generate_config
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
  end
end