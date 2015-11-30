require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  it 'should have a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'can top up the balance' do
      expect{ card.top_up 1 }.to change{ card.balance }.by 1
    end

    it 'raises an error if the BALANCE_LIMIT is exceeded' do
      maximum_value = Oystercard::BALANCE_LIMIT
      card.top_up(maximum_value)
      expect{ card.top_up 1 }.to raise_error("Maximum value of £#{maximum_value} exceeded")
    end
  end

  describe '#deduct' do
    it 'reduces the balance' do
      expect{ card.deduct 1 }.to change{ card.balance }.by -1
    end
  end
end
