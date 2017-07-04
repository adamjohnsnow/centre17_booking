describe Slot do

  it 'opens the correct slots' do
    Slot.open_dates('01/01/2017', '01/01/2017')
    expect(Slot.all.count).to eq 16
  end

  it 'saves correct details to slot' do
    slot = Slot.get(10)
    expect(slot.date).to eq DateTime.new(2017, 01, 01)
    expect(slot.hour).to eq 17
    expect(slot.status).to eq 'available'
    expect(slot.booking_id).to eq nil
  end
end
