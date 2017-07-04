describe User do

  scenario 'create user' do
    User.create("Firstname", "Surname", "email@email.com", "07777123456", "password")
    expect(User.all.count).to eq 1
  end

  scenario 'no duplicate user' do
    User.create("Firstname", "Surname", "email@email.com", "07777123456", "password")
    expect(User.all.count).to eq 1
  end

  scenario 'add second user' do
    User.create("Firstname", "Surname", "email2@email.com", "07777123456", "password")
    expect(User.all.count).to eq 2
  end

  it { expect(User.first.firstname).to eq "Firstname" }

  it { expect(User.first.surname).to eq "Surname" }

  it { expect(User.first.email).to eq "email@email.com" }

  it { expect(User.first.phone).to eq "07777123456" }

  it { expect(User.first.cash_balance).to eq 0 }

  it { expect(User.first.time_balance).to eq 0 }

  it { expect(User.first.status).to eq 'pending' }

end
