describe "Features Tests" do

let(:oystercard) {Oystercard.new}
let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
let(:minimum_fare) {Oystercard::MINIMUM_FARE}
let(:station) {double :station}


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

  it 'allow card to be touched in' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(station)
    expect(oystercard.in_journey?).to eq true
  end

  it 'allow card to be touched out' do
    oystercard.touch_out
    expect(oystercard.in_journey?).to eq false
  end

  it 'prevents touching in if insufficient funds' do
    expect{oystercard.touch_in(station)}.to raise_error 'Insufficient funds: top up'
  end

  it 'deducts fare from oystercard' do
    expect{oystercard.touch_out}.to change{oystercard.balance}.by(-minimum_fare)
  end

  it 'remembers the entry station after touch in' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in(station)
    expect(oystercard.entry_station).to eq station
  end

end
