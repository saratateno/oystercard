require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:station1) {Station.new('Kings Cross',1)}
  let(:station2) {Station.new('Shoreditch',1)}
  
  it 'stores an entry station when a journey begins' do
    journey.begin(station1)
    expect(journey.entry_station).to eq station1
  end
end
