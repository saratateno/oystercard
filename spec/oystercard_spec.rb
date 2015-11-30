require 'oystercard'

describe Oystercard do

subject(:oystercard) {described_class.new}
let(:limit_fail) {Oystercard::Limit_fail}
let(:limit) {Oystercard::Limit}

context 'balance on the card' do
  it 'starting balance at 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'adds the arguement to the balance of the card' do
    oystercard.top_up(5)
    expect(oystercard.balance).to eq 5
  end

  it 'limits the amount allowed on card' do
    oystercard.top_up(limit)
    expect{oystercard.top_up(5)}.to raise_error limit_fail
  end

  it 'deducts the fair from the card' do
    oystercard.deduct(5)
    expect(oystercard.balance).to eq -5
  end
end

context 'starting and ending journey' do
   it 'confirms passenger in journey' do
    oystercard.touch_in
    expect(oystercard.in_journey?).to eq true
   end

   it 'confirms passenger not in journey' do
     oystercard.touch_out
     expect(oystercard.in_journey?).to eq false
   end
end
end
