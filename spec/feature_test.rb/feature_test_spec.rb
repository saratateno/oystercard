describe "Features Tests" do

let(:oystercard) {Oystercard.new}
let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
let(:minimum_fare) {Journey::MINIMUM_FARE}
let(:in_station) {Station.new('Aldgate',1)}
let(:out_station) {Station.new('Bank',1)}
let(:station) {Station.new('Shoreditch',1)}
let(:journey) {Journey.new}
let(:penalty) {Journey::PENALTY}

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
    expect{oystercard.touch_in(in_station)}.to raise_error 'Insufficient funds: top up'
  end

  it 'deducts fare from oystercard' do
    oystercard.top_up(10)
    oystercard.touch_in(station)
    expect{oystercard.touch_out(out_station)}.to change{oystercard.balance}.by(-minimum_fare)
  end

  it 'remembers the entry station after touch in' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(in_station)
    expect(oystercard.journey.current[:entry_station]).to eq in_station
  end

  it 'forgets the entry station on touch out' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(in_station)
    oystercard.touch_out(out_station)
    expect(oystercard.journey.current).to eq Hash.new
  end

  it 'store a journey' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(in_station)
    oystercard.touch_out(out_station)
    current_journey = { entry_station: in_station, exit_station: out_station }
    expect(oystercard.journey.log).to eq [current_journey]
  end

  it 'starts with an empty journey history' do
     expect(oystercard.journey.log).to be_empty
  end

  it 'creates a new station and sets its name as an instance variable' do
    expect(station.name).to eq 'Shoreditch'
  end

  it 'creates a new station and sets its zone as an instance variable' do
    expect(station.zone).to eq 1
  end

  describe 'Journey' do
    it 'saves entry station when journey begins' do
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

    it 'calculates a fare when journey ends' do
      journey.begin(in_station)
      journey.end(out_station)
      expect(journey.fare).to eq minimum_fare
    end

    it 'tracks if in a journey when one has begun' do
      journey.begin(in_station)
      expect(journey.in_journey?).to eq true
    end

    it 'tracks it is not in a journey when one has ended' do
      journey.begin(in_station)
      journey.end(out_station)
      expect(journey.in_journey?).to eq false
    end

    it 'issues penalty when beginning a journey without touching out previous journey' do
      oystercard.top_up(10)
      oystercard.touch_in(in_station)
      expect{oystercard.touch_in(in_station)}.to change{oystercard.balance}.by(-penalty)
    end

    it 'issues penalty when ending a journey without having touched in' do
      oystercard.top_up(10)
      expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-penalty)
    end
  end

end
