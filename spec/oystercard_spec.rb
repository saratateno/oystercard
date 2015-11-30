require 'oystercard'

describe Oystercard do

subject(:oystercard) {described_class.new}

  it 'starting balance at 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'adds the arguement to the balance of the card' do
    oystercard.top_up(5)
    expect(oystercard.balance).to eq 5
  end

end
