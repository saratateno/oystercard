describe "Features Tests" do

let(:oystercard) {Oystercard.new}
let(:limit) {Oystercard::Limit}
let(:minimum_fare) {Oystercard::Minimum_fare}
let(:insufficient_funds) {Oystercard::Insufficient_funds}

 it 'creates a new oystercard with a balance of 0' do
   expect(oystercard.balance).to eq 0
 end

  it 'allows money to be added to the card' do
    oystercard.top_up(minimum_fare)
    expect(oystercard.balance).to eq minimum_fare
  end

   it 'limits the amount allowed on card' do
     oystercard.top_up(limit)
     expect{oystercard.top_up(minimum_fare)}.to raise_error 'ERROR - oystercard limited to £90'
   end

  it 'deducts the fare from the oyster card' do
    oystercard.deduct(minimum_fare)
    expect(oystercard.balance).to eq -minimum_fare
  end

  it 'allow card to be touched in' do
    oystercard.top_up(minimum_fare)
    oystercard.touch_in
    expect(oystercard.in_journey?).to eq true
  end

  it 'allow card to be touched out' do
    oystercard.touch_out
    expect(oystercard.in_journey?).to eq false
  end

  it 'prevents touching in if insufficient funds' do
    expect{oystercard.touch_in}.to raise_error insufficient_funds
  end

end
