describe "Features Tests" do

let(:oystercard) {Oystercard.new}
let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
let(:minimum_fare) {Oystercard::MINIMUM_FARE}
let(:in_station) {double :station}
let(:out_station) {double :station}
let(:station) {Station.new('Shoreditch',1)}


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
    expect{oystercard.touch_out(out_station)}.to change{oystercard.balance}.by(-minimum_fare)
  end

  it 'remembers the entry station after touch in' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(in_station)
    expect(oystercard.entry_station).to eq in_station
  end

  it 'forgets the entry station on touch out' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(in_station)
    oystercard.touch_out(out_station)
    expect(oystercard.entry_station).to eq nil
  end

  it 'store a journey' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(in_station)
    oystercard.touch_out(out_station)
    current_journey = { entry_station: in_station, exit_station: out_station }
    expect(oystercard.current_journey).to eq current_journey
  end

  it 'starts with an empty journey history' do
     expect(oystercard.history).to be_empty
  end

  it 'creates a new station and sets its name as an instance variable' do
    expect(station.name).to eq 'Shoreditch'
  end

  it 'creates a new station and sets its zone as an instance variable' do
    expect(station.zone).to eq 1
  end
end
