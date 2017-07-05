
feature 'Homepage' do
  after do
    DatabaseCleaner.clean
  end

  scenario 'fail to sign in' do
    visit '/'
    fill_in 'email address', with: 'email'
    fill_in 'password', with: 'notmypassword'
    click_button 'submit'
    expect(page).to have_content 'you could not be signed in, try again'
  end

  scenario 'try to sign up, non-match passwords' do
    visit '/'
    click_link 'New Users Register'
    fill_in 'firstname', with: 'Mister'
    fill_in 'surname', with: 'Something'
    fill_in 'email address', with: 'email@email.com'
    fill_in 'phone', with: '0123456789'
    fill_in 'password', with: 'notmypassword'
    fill_in 'verify_password', with: 'notyourpassword'
    fill_in 'comments', with: 'This is my reason'
    click_button 'submit'
    expect(User.all.count).to eq 0
    expect(page).to have_content 'your passwords did not match, try again'
  end

  scenario 'sign up, see that no bookings made' do
    visit '/'
    click_link 'New Users Register'
    fill_in 'firstname', with: 'Mister'
    fill_in 'surname', with: 'Something'
    fill_in 'email address', with: 'email@email.com'
    fill_in 'phone', with: '0123456789'
    fill_in 'password', with: 'notmypassword'
    fill_in 'verify_password', with: 'notmypassword'
    fill_in 'comments', with: 'This is my reason'
    click_button 'submit'
    expect(User.all.count).to eq 1
    expect(page).to have_content 'Welcome back, Mister'
    expect(page).to have_content 'You currently have no active bookings'
  end

  scenario 'log in, make booking search' do
    sign_up
    click_link 'Request New Booking'
    expect(page).to have_content 'Select date to search from'
  end
end
