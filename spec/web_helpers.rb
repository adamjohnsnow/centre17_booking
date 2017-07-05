def sign_up
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
end
