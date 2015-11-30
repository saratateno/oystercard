require 'oystercard'

describe Oystercard do

subject(:oystercard) {described_class.new}
let(:limit_fail) {Oystercard::Limit_fail}
let(:limit) {Oystercard::Limit}
let(:minimum_fare) {Oystercard::Minimum_fare}
let(:insufficient_funds) {Oystercard::Insufficient_funds}

context 'balance on the card' do
  it 'starting balance at 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'adds the arguement to the balance of the card' do
    oystercard.top_up(minimum_fare)
    expect(oystercard.balance).to eq minimum_fare
  end

  it 'limits the amount allowed on card' do
    oystercard.top_up(limit)
    expect{oystercard.top_up(minimum_fare)}.to raise_error limit_fail
  end
end

context 'starting and ending journey' do
   it 'confirms passenger in journey' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in
    expect(oystercard.in_journey?).to eq true
   end

   it 'confirms passenger not in journey' do
     oystercard.touch_out
     expect(oystercard.in_journey?).to eq false
   end

   it 'prevents touching in if insufficient funds' do
     expect{oystercard.touch_in}.to raise_error insufficient_funds
   end

   it 'deducts fare from oystercard' do
     expect{oystercard.touch_out}.to change{oystercard.balance}.by(-minimum_fare)
   end
end
end
