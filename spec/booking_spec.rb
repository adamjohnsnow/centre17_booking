describe Booking do

  scenario 'create booking' do
    Booking.create(
        user_id: 1,
        title: "Test",
        description: "A description of this booking, might be very long, might not be",
        date_time: "14:00 01/06/2017",
        duration: 2
        )
    expect(Booking.all.count).to eq 1
    expect(Booking.first.title).to eq 'Test'
    expect(Booking.first.date_time).to eq(DateTime.new(2017, 06 ,01 , 14, 00, 00, "+01:00"))
  end

  scenario 'booking gets confirmed' do
    test_booking = Booking.first
    test_booking.confirm(100.25, 2, "This is going to work")
    expect(test_booking.status).to eq 'confirmed'
    expect(test_booking.cash_quote).to eq 100.25
    expect(test_booking.time_quote).to eq 2
    expect(test_booking.admin_notes).to eq "This is going to work"
  end


end
