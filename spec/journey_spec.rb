require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:in_station)  { double :station     }
  let(:out_station) { double :station     }

  it { is_expected.to respond_to(:current) }

  it { is_expected.to respond_to(:begin).with(1).argument }

  it { is_expected.to respond_to(:end).with(1).argument }

  it { is_expected.to respond_to(:log) }

  it 'expects to store entry station' do
    journey.begin(in_station)
    current_journey = {entry_station: in_station}
    expect(journey.current).to eq current_journey
  end

  it 'saves exit station when journey ends' do
    journey.end(out_station)
    expect(journey.log[0][:exit_station]).to eq out_station
  end

  it 'saves complete journey in a journey log' do
    journey.begin(in_station)
    journey.end(out_station)
    journey_log = [{entry_station: in_station, exit_station: out_station}]
    expect(journey.log).to eq journey_log
  end

  it 'clears current journey when journey ends' do
    journey.begin(in_station)
    journey.end(out_station)
    expect(journey.current).to eq Hash.new
  end

end
