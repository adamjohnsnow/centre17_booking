describe Booking do

  it 'create booking' do
    Booking.create(
        user_id: 1,
        title: "Test",
        description: "A description of this booking, might be very long, might not be",
        tickets: true,
        date_time: '13:00 10/08/2017',
        duration: 2
        )
    expect(Booking.all.count).to eq 1
    expect(Booking.first.title).to eq 'Test'
    expect(Booking.first.tickets).to eq true
    expect(Booking.first.duration).to eq 2
  end

end
