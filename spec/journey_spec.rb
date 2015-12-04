require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:station1) {Station.new('Kings Cross',1)}
  let(:station2) {Station.new('Shoreditch',1)}
  let(:minimum_fare) {Journey::MINIMUM_FARE}

  it 'stores an entry station when a journey begins' do
    journey.begin(station1)
    expect(journey.entry_station).to eq station1
  end

  it 'stores an exit station when a journey ends' do
    journey.end(station2)
    expect(journey.exit_station).to eq station2
  end

  it 'calculates the fare for a complete journey' do
    expect(journey.fare).to eq minimum_fare
  end

end
