describe SlotSearch do
  after do
    DatabaseCleaner.clean
  end

  it 'returns the correct filtered slots - one hour morning' do
    create_two_day_slots
    book_one_slot
    params = { date: "01/08/2017", "morning" => "on", :duration => 1 }
    search = SlotSearch.search(params)
    expect(search.length).to eq 9
  end

  it 'returns the correct filtered slots - two hour morning' do
    create_two_day_slots
    book_one_slot
    params = { date: "01/08/2017", "morning" => "on", :duration => 2 }
    search = SlotSearch.search(params)
    expect(search.length).to eq 8
  end

  it 'returns the correct filtered slots - two hour evening' do
    create_two_day_slots
    params = { date: "01/08/2017", "evening" => "on", :duration => 2 }
    search = SlotSearch.search(params)
    expect(search.length).to eq 10
  end

  it 'returns the correct filtered slots - three hour evening' do
    create_two_day_slots
    params = { date: "01/08/2017", "evening" => "on", :duration => 3 }
    search = SlotSearch.search(params)
    expect(search.length).to eq 8
  end

end
