Migu.configuration do |config|
  config.before do
    p "before"
  end

  config.after do
    p "after"
  end
end

class CreateUsers < Migu::Migration
  def self.time
    "2019-01-01 00:00:00 +0900"
  end

  def up
    p "create users"
  end

  def down
    p "drop users"
  end
end

class CreatePosts < Migu::Migration
  def self.time
    "2019-01-02 00:00:00 +0900"
  end

  def up
    p "create posts"
  end

  def down
    p "drop posts"
  end
end

RSpec.describe Migu::Migrator do
  before do
    Migu::State.new.reset_table
    Migu::State.new.create_table
  end

  after do
    Migu::State.new.reset_table
  end

  describe "#migrate" do
    it "migrates" do
      Migu::Migrator.new.migrate
      expect(Migu::State.new.migrated[0][1]).to eq("CreateUsers")
    end

    it "migrates in order" do
      Migu::Migrator.new.migrate
      expect(Migu::State.new.migrated[1][1]).to eq("CreatePosts")
    end

    context "when migration is already applied" do
      before do
        Migu::Migrator.new.migrate
      end

      it "does not migrate" do
        Migu::Migrator.new.migrate
        expect(Migu::State.new.migrated.size).to eq(2)
      end
    end
  end

  describe "#rollback" do
    before do
      Migu::State.new.reset_table
      Migu::State.new.create_table
      Migu::Migrator.new.migrate
    end

    after do
      Migu::State.new.reset_table
    end

    it "rollbacks" do
      Migu::Migrator.new.rollback
      expect(Migu::State.new.migrated.size).to eq(1)
    end
  end
end