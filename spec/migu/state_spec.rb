RSpec.describe Migu::State do
  before do
    Migu::State.new.reset_table
    Migu::State.new.create_table
  end

  after do
    Migu::State.new.reset_table
  end

  describe '#insert' do
    it 'inserts row' do
      Migu::State.new.insert('foo', '2019-01-01 00:00:00', '2019-01-01 00:00:00')
      expect(Migu::State.new.find('foo')).to eq([1, 'foo', '2019-01-01 00:00:00', '2019-01-01 00:00:00'])
    end
  end

  describe '#delete' do
    before do
      Migu::State.new.insert('foo', '2019-01-01 00:00:00', '2019-01-01 00:00:00')
    end

    it 'deletes row' do
      Migu::State.new.delete('foo')
      expect(Migu::State.new.find('foo')).to eq(nil)
    end
  end

  describe '#find' do
    before do
      Migu::State.new.insert('foo', '2019-01-01 00:00:00', '2019-01-01 00:00:00')
    end

    it 'finds row' do
      expect(Migu::State.new.find('foo')).to eq([1, 'foo', '2019-01-01 00:00:00', '2019-01-01 00:00:00'])
    end
  end

  describe '#migrated' do
    before do
      Migu::State.new.insert('foo', '2019-01-01 00:00:00', '2019-01-01 00:00:00')
      Migu::State.new.insert('bar', '2019-01-02 00:00:00', '2019-01-01 00:00:00')
    end

    it 'finds migrated' do
      expect(Migu::State.new.migrated).to eq([
        [1, 'foo', '2019-01-01 00:00:00', '2019-01-01 00:00:00'],
        [2, 'bar', '2019-01-02 00:00:00', '2019-01-01 00:00:00']
      ])
    end
  end
end