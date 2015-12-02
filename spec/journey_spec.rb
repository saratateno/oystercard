require 'journey'

describe Journey do

    let(:oystercard) {double :oystercard, touch_in: station}
    let(:in_station) {double :station}
    let(:out_station) {double :station}


    it 'remembers the entry station after touch in' do
      oystercard.top_up(minimum_fare)
      oystercard.touch_in(in_station)
      expect(oystercard.entry_station).to eq in_station
    end


end
