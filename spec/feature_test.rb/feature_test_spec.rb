describe "Features Tests" do

let(:oystercard) {Oystercard.new}
let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
let(:minimum_fare) {Oystercard::MINIMUM_FARE}
let(:station) {double :station}
let(:in_station) {double :station}
let(:out_station) {double :station}


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
    expect{oystercard.touch_in(station)}.to raise_error 'Insufficient funds: top up'
  end

  it 'deducts fare from oystercard' do
    expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-minimum_fare)
  end

  it 'remembers the entry station after touch in' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(station)
    expect(oystercard.entry_station).to eq station
  end

  it 'forgets the entry station on touch out' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(station)
    oystercard.touch_out(station)
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
  #
  # it 'stores multiple journeys' do
  #   2.times do
  #     oystercard.top_up(minimum_fare)
  #     oystercard.touch_in(in_station)
  #     oystercard.touch_out(out_station)
  #   end
  #   expect(oystercard.history).to eq
  # end

end
