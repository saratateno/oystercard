describe "Features Tests" do

let(:oystercard) {Oystercard.new}
let(:limit) {Oystercard::Limit}

 it 'creates a new oystercard with a balance of 0' do
   expect(oystercard.balance).to eq 0
 end

  it 'allows money to be added to the card' do
    oystercard.top_up(5)
    expect(oystercard.balance).to eq 5
  end

   it 'limits the amount allowed on card' do
     oystercard.top_up(limit)
     expect{oystercard.top_up(5)}.to raise_error 'ERROR - oystercard limited to £90'
   end
#    In order to pay for my journey
# As a customer
# I need my fare deducted from my card

  it 'deducts the fare from the oyster card' do
    oystercard.deduct(5)
    expect(oystercard.balance).to eq -5
  end

end
