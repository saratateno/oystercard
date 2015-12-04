require 'oystercard'

describe Oystercard do

subject(:oystercard) {described_class.new}
let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
let(:minimum_fare) {Oystercard::MINIMUM_FARE}
let(:station) {double :station}
let(:station1) {double :station}
let(:station2) {double :station}

  describe '#balance' do
    it 'starting balance at 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds an amount to the balance of the card' do
      expect{oystercard.top_up(1)}.to change{oystercard.balance}.by(1)
    end

    it 'limits the amount allowed on card' do
      oystercard.top_up(maximum_balance)
      expect{oystercard.top_up(1)}.to raise_error "ERROR - oystercard limited to £#{maximum_balance}"
    end
  end

  describe '#touch_in' do

    it 'prevents touching in if insufficient funds' do
       expect{oystercard.touch_in(station)}.to raise_error 'Insufficient funds: top up'
    end

    it 'remembers the entry station upon touch in' do
      oystercard.top_up(minimum_fare)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

  end

  describe '#touch_out' do

    it 'deducts fare from oystercard' do
      expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-minimum_fare)
    end

    it 'sets entry station to equal nil' do
      oystercard.top_up(minimum_fare)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard.entry_station).to eq nil
    end

    it 'starts with an empty journey history' do
       expect(oystercard.history).to be_empty
    end

    it 'stores a journey history' do
      oystercard.top_up(minimum_fare)
      oystercard.touch_in(station1)
      oystercard.touch_out(station2)
      journey1 = { entry_station: station1, exit_station: station2 }
      expect(oystercard.history[:journey1]).to eq journey1
    end
  end
end
