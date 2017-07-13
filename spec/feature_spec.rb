
feature 'Homepage' do
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
    expect(page).to have_content 'your passwords did not match, try again'
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
    click_link 'Request New Booking'
    expect(page).to have_content 'Select date to search from'
  end

  scenario 'make booking search' do
    do_search
    expect(page).to have_content 'Available slots within 7 days of your search:'
    expect(page).to have_content '07/07/2017 14:00-17:00 book'
  end

  scenario 'book slot' do
    do_search
    click_link('book', :match => :first)
    expect(page).to have_content 'To finalise your booking request for 07/07'
  end

  scenario 'request booking' do
    do_search
    click_link('book', :match => :first)
    fill_in 'title', with: "Event One"
    check 'lighting'
    click_button 'Make Booking Request'
    expect(Booking.all.count).to eq 1
    expect(Booking.first.lighting).to be true
    expect(Booking.first.slots.count).to eq 3
    expect(page).to have_content 'Thank you for your booking request. Someone from the CentrE17'
    expect(page).to have_content 'Event One'
    expect(page).to have_content '07/07'
    expect(page).to have_content 'Status: pending'
  end
end
