
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

  scenario 'sign up' do
    visit '/'
    click_link 'New Users Register'
    fill_in 'firstname', with: 'Mister'
    fill_in 'surname', with: 'Something'
    fill_in 'email address', with: 'email@email.com'
    fill_in 'phone', with: '0123456789'
    fill_in 'password', with: 'notmypassword'
    fill_in 'verify_password', with: 'notmypassword'
    click_button 'submit'
    expect(User.all.count).to eq 1
    expect(page).to have_content 'Welcome back, Mister'
  end
end
