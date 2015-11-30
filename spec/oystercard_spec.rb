require 'oystercard'

describe Oystercard do
  it 'responds to balance' do
  expect(subject).to respond_to(:balance)
end

  it 'starting balance at 0' do
    expect(subject.balance).to eq 0
  end
end
