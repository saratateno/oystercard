describe "Features Tests" do

let(:oystercard) {Oystercard.new}
let(:journey) {Journey.new}
let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
let(:minimum_fare) {Oystercard::MINIMUM_FARE}
let(:station1) {Station.new('Kings Cross',1)}
let(:station2) {Station.new('Shoreditch',1)}


  it 'creates a new oystercard with a balance of 0' do
     expect(oystercard.balance).to eq 0
  end

  it 'allows money to be added to the card' do
    oystercard.top_up(minimum_fare)
    expect(oystercard.balance).to eq minimum_fare
  end

   it 'limits the amount allowed on card' do
     oystercard.top_up(maximum_balance)
     expect{oystercard.top_up(1)}.to raise_error "ERROR - oystercard limited to £#{maximum_balance}"
   end

  it 'prevents touching in if insufficient funds' do
    expect{oystercard.touch_in(station1)}.to raise_error 'Insufficient funds: top up'
  end

  it 'deducts fare from oystercard' do
    expect{oystercard.touch_out(station1)}.to change{oystercard.balance}.by(-minimum_fare)
  end

  it 'remembers the entry station after touch in' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(station1)
    expect(oystercard.entry_station).to eq station1
  end

  it 'forgets the entry station on touch out' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(station1)
    oystercard.touch_out(station2)
    expect(oystercard.entry_station).to eq nil
  end

  it 'stores a journey history' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(station1)
    oystercard.touch_out(station2)
    journey1 = { entry_station: station1, exit_station: station2 }
    expect(oystercard.history[:journey1]).to eq journey1
  end

  it 'starts with an empty journey history' do
     expect(oystercard.history).to be_empty
  end

  it 'creates a new station and sets its name as an instance variable' do
    expect(station1.name).to eq 'Kings Cross'
  end

  it 'creates a new station and sets its zone as an instance variable' do
    expect(station1.zone).to eq 1
  end

  describe 'Journey class' do

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

  end

end
