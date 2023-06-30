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
end
