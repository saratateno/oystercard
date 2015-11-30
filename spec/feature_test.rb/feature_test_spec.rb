describe "Features Tests" do
 it 'creates a new oystercard with a balance of 0' do
   oystercard = Oystercard.new
   expect(oystercard.balance).to eq 0 
 end

end
