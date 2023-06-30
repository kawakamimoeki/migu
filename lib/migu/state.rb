require "sqlite3"

module Migu
  class State
    attr_reader :db

    def initialize
      Dir.mkdir("migu") unless Dir.exist?("migu")
      File.open("migu/state.sqlite3", "w") {} unless File.exist?("migu/state.sqlite3")
      @db = SQLite3::Database.new("migu/state.sqlite3")
    end

    def create_table
      if db.execute("select * from sqlite_master where type = 'table' and name = 'state'").empty?
        rows = db.execute <<-SQL
          create table state (
            id integer primary key autoincrement,
            migration_name text not null,
            defined_at datetime not null,
            created_at datetime not null
          );
        SQL
      end
    end

    def reset_table
      unless db.execute("select * from sqlite_master where type = 'table' and name = 'state'").empty?
        db.execute("drop table state")
      end
    end

    def insert(migration_name, defined_at, created_at = Time.now.to_s)
      db.execute(
        "insert into state (migration_name, defined_at, created_at) values (?, ?, ?)",
        migration_name,
        defined_at,
        created_at
      ) do |row|
        return row
      end
    end

    def delete(migration_name)
      db.execute("delete from state where migration_name = ?", migration_name) do |row|
        return row
      end
    end

    def find(migration_name)
      db.execute("select * from state where migration_name = ?", migration_name) do |row|
        return row
      end
    end

    def migrated
      rows = []
      db.execute("select * from state order by defined_at asc") do |row|
        rows << row
      end
      rows
    end
  end
end