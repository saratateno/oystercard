require 'oystercard'

describe Oystercard do

subject(:oystercard) {described_class.new}
let(:limit_fail) {Oystercard::Limit_fail}

  it 'starting balance at 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'adds the arguement to the balance of the card' do
    oystercard.top_up(5)
    expect(oystercard.balance).to eq 5
  end

  it 'limits the amount allowed on card' do
    oystercard.top_up(90)
    expect{oystercard.top_up(5)}.to raise_error limit_fail
  end
end
