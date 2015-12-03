require 'station'

describe Station do

  subject(:station) { described_class.new(name: 'Shoreditch', zone: 1) }

  it 'sets its name as an instance variable' do
    expect(station.name).to eq 'Shoreditch'
  end

  it 'sets its zone as an instance variable' do
    expect(station.zone).to eq 1
  end

end
