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

  it 'knows when a journey is in progress' do
    journey.begin(station1)
    expect(journey.in_journey?).to eq true
  end

  it 'knows that it is not in a journey when one has ended' do
    journey.begin(station1)
    journey.end(station2)
    expect(journey.in_journey?).to eq false
  end

  it 'doesn\'t incur a penalty when a journey is complete' do
    journey.begin(station1)
    journey.end(station2)
    expect(journey.incur_penalty?).to eq false
  end

  it 'incurs a penalty when a journey has started but not ended' do
    allow(journey).to receive(:in_journey?) {true}
    journey.begin(station2)
    expect(journey.incur_penalty?).to eq true
  end

end
