describe "Features Tests" do

 it 'creates a new oystercard with a balance of 0' do
   oystercard = Oystercard.new
   expect(oystercard.balance).to eq 0
 end

#  In order to keep using public transport
# As a customer
# I want to add money to my card

  it 'allows money to be added to the card' do
    oystercard = Oystercard.new
    oystercard.top_up(5)
    expect(oystercard.balance).to eq 5
  end

end
