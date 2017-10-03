
feature 'User Journey' do
  after do
    DatabaseCleaner.clean
  end

  scenario 'fail to sign in' do
    visit '/'
    fill_in 'email', with: 'email'
    fill_in 'password', with: 'notmypassword'
    click_button 'submit'
    expect(page).to have_content 'You could not be signed in, please try again or register'
  end

  scenario 'try to sign up, non-match passwords' do
    visit '/'
    click_link 'New Users Register'
    fill_in 'firstname', with: 'Mister'
    fill_in 'surname', with: 'Something'
    fill_in 'email', with: 'email@email.com'
    fill_in 'phone', with: '0123456789'
    fill_in 'password', with: 'notmypassword'
    fill_in 'verify_password', with: 'notyourpassword'
    fill_in 'comments', with: 'This is my reason'
    click_button 'submit'
    expect(User.all.count).to eq 0
    expect(page).to have_content 'Your passwords did not match, please try again'
  end

  scenario 'sign up, see approval notice' do
    visit '/'
    click_link 'New Users Register'
    fill_in 'firstname', with: 'Mister'
    fill_in 'surname', with: 'Something'
    fill_in 'email', with: 'email@email.com'
    fill_in 'phone', with: '0123456789'
    fill_in 'password', with: 'notmypassword'
    fill_in 'verify_password', with: 'notmypassword'
    fill_in 'comments', with: 'This is my reason'
    click_button 'submit'
    expect(User.all.count).to eq 1
    expect(page).to have_content 'Your account has been sent for approval. Once validated you will receive an approval email. Thanks.'
  end

  scenario 'got to search page' do
    sign_up
    sign_in
    click_button 'Request New Booking'
    expect(page).to have_content 'Search for availability'
  end

  scenario 'make booking search' do
    do_search
    expect(page).to have_content 'Available slots within 7 days of your search:'
    expect(page).to have_content '07/11/2017 13:00 - 16:00'
  end

  scenario 'book slot' do
    do_search
    click_link('13:00 - 16:00', :match => :first)
    expect(page).to have_content '07/11/2017 from 13:00'
  end

  scenario 'request booking' do
    do_search
    click_link('13:00 - 16:00', :match => :first)
    fill_in 'title', with: "Event One"
    check 'lighting'
    click_button 'Make Booking Request'
    expect(Booking.all.count).to eq 1
    expect(Booking.first.lighting).to be true
    expect(page).to have_content 'Thank you for your booking request. Someone from the CentrE17'
    expect(page).to have_content 'Event One'
    expect(page).to have_content '07/11'
    expect(page).to have_content 'Status: Pending'
  end
end

feature 'Admin Journey' do
  after do
    DatabaseCleaner.clean
  end

  scenario 'not admin' do
    sign_up_admin
    sign_up
    sign_in
    visit '/admin'
    expect(page).to have_content 'Hello, Mister'
  end

  scenario 'admin login' do
    sign_up
    sign_up_admin
    sign_in
    visit '/admin'
    expect(page).to have_content 'On Today'
  end

  scenario 'has pending event' do
    make_booking
    visit '/admin'
    expect(page).to have_content 'Event One'
  end

  scenario 'go to pending event' do
    make_booking
    visit '/admin'
    click_link('Event One', :match => :first)
    expect(page).to have_content 'from Mister Something'
  end

  scenario 'approve pending event' do
    make_booking
    visit '/admin'
    click_link('Event One', :match => :first)
    fill_in 'admin_notes', with: 'Some text'
    select 'Approved', from: "status"
    click_button 'submit'
    expect(Booking.first.status).to eq 'Approved'
    expect(Booking.first.admin_notes).to eq 'Some text'
  end
end
