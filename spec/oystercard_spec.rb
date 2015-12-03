require 'oystercard'

describe Oystercard do

subject(:oystercard) {described_class.new}
let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
let(:minimum_fare) {Oystercard::MINIMUM_FARE}
let(:station) {double :station}
let(:in_station) {double :station}
let(:out_station) {double :station}

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

    it 'store a journey' do
      oystercard.top_up(minimum_fare)
      oystercard.touch_in(in_station)
      oystercard.touch_out(out_station)
      current_journey = { entry_station: in_station, exit_station: out_station }
      expect(oystercard.history).to eq [current_journey]
    end

    it 'starts with an empty journey history' do
       expect(oystercard.history).to be_empty
    end
  end

  describe 'edge cases' do
    it 'issues penalty when beginning a journey while already in a journey' do
      oystercard.top_up(10)
      oystercard.touch_in(in_station)
      expect{oystercard.touch_in(in_station)}.to change{oystercard.balance}.by(-penalty)
    end

  end

end
