require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:station1) {Station.new('Kings Cross',1)}
  let(:station2) {Station.new('Shoreditch',1)}
  let(:minimum_fare) {Journey::MINIMUM_FARE}
  let(:penalty_charge) {Journey::PENALTY_CHARGE}


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

  it 'charges a fine if the user has incurred a penalty' do
    allow(journey).to receive(:incur_penalty) {true}
    expect(journey.penalty).to eq penalty_charge
  end

  it 'does not charge a fine if the user has not incurred a penalty' do
    allow(journey).to receive(:incur_penalty) {false}
    expect(journey.penalty).to eq 0
  end

  it 'stores information about the last journey' do
    journey.begin(station1)
    journey.end(station2)
    expect(journey.info).to eq({entry: station1, exit: station2})
  end

end
