describe "Features Tests" do

let(:oystercard) {Oystercard.new}

 it 'creates a new oystercard with a balance of 0' do
   expect(oystercard.balance).to eq 0
 end

#  In order to keep using public transport
# As a customer
# I want to add money to my card

  it 'allows money to be added to the card' do
    oystercard.top_up(5)
    expect(oystercard.balance).to eq 5
  end

   it 'limits the amount allowed on card' do
     oystercard.top_up(90)
     expect{oystercard.top_up(5)}.to raise_error 'ERROR - oystercard limited to £90'
   end

end
