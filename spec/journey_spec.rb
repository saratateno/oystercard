require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:in_station)  { double :station     }
  let(:out_station) { double :station     }
  let(:minimum_fare) { Journey::MINIMUM_FARE}
  let(:penalty) {Journey::PENALTY}

  context 'in a journey' do
    before(:each) {journey.begin(in_station)}

    it 'expects to store entry station' do
      current_journey = {entry_station: in_station}
      expect(journey.current).to eq current_journey
    end

    it 'saves exit station when journey ends' do
      journey.end(out_station)
      expect(journey.log[0][:exit_station]).to eq out_station
    end

    it 'saves complete journey in a journey log' do
      journey.end(out_station)
      journey_log = [{entry_station: in_station, exit_station: out_station}]
      expect(journey.log).to eq journey_log
    end

    it 'clears current journey when journey ends' do
      journey.end(out_station)
      expect(journey.current).to eq Hash.new
    end

    it 'calculates a fare' do
      journey.end(out_station)
      expect(journey.fare).to eq minimum_fare
    end

    it 'tracks if in a journey' do
      expect(journey.in_journey?).to eq true
    end

    it 'tracks it is not in a journey when one has ended' do
      journey.end(out_station)
      expect(journey.in_journey?).to eq false
    end

    it 'issues penalty when beginning a journey without ending previous journey' do
      journey.begin(in_station)
      journey.begin(in_station)
      expect(journey.penalty).to eq penalty
    end
  end

  context 'edge case' do
    it 'issues penalty when ending a journey without having begun a journey' do
      journey.end(out_station)
      expect(journey.penalty).to eq penalty
    end
  end
end
