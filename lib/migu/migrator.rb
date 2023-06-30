module Migu
  class Migrator
    attr_reader :migrations

    def initialize(migrations = Migu::Migration.subclasses)
      @migrations = migrations.sort { |a, b| a.time <=> b.time }
    end

    def state
      Migu::State.new
    end

    def migrate
      migrations.each do |migration|
        unless state.find(migration.name)
          puts "==== Migrate #{migration.name} ===="
          migration.new.up
          state.insert(migration.name, migration.time.to_s)
        end
      end
    end

    def rollback
      if state.migrated.empty?
        puts "==== No migrations to rollback ===="
        return
      end
      migration = migrations.find { |migration|
        migration.name == state.migrated.last[1]
      }
      puts "==== Rollback #{migration.name} ===="
      migration.new.down
      state.delete(migration.name)
    end
  end
end