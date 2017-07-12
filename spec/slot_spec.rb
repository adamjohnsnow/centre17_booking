describe Slot do

  it 'opens the correct slots' do
    Slot.open_dates('07/07/2017', '07/07/2017')
    expect(Slot.all.count).to eq 16
  end

  it 'saves correct details to slot' do
    slot = Slot.get(10)
    expect(slot.date).to eq DateTime.new(2017, 07, 07, 00, 00, 00, '+01:00')
    expect(slot.hour).to eq 17
    expect(slot.status).to eq 'available'
    expect(slot.base_price).to eq 30
    expect(slot.booking_id).to eq nil
  end

  it 'gives peak prices' do
    slot = Slot.get(12)
    expect(slot.base_price).to eq 40
  end

  it 'books a slot' do
    Slot.book_slots('07/07/2017', 10, 2, 1)
    expect(Slot.get(3).status).to eq 'booked'
    expect(Slot.get(4).status).to eq 'booked'
  end
end
