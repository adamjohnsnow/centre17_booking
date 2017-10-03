def sign_up
  user = User.create('Mister', 'Something', 'email@email.com', '123456', 'notmypassword', 'This is my reason')
  user.status = 'Approved'
  user.save!
end

def sign_in
  visit '/'
  fill_in 'email', with: 'email@email.com'
  fill_in 'password', with: 'notmypassword'
  click_button 'submit'
end

def do_search
  sign_up
  sign_in
  click_button 'Request New Booking'
  fill_in 'date', with: '07/11/2017'
  fill_in 'duration', with: 3
  check 'afternoon'
  click_button 'Start search'
end

def make_booking
  do_search
  click_link('13:00 - 16:00', :match => :first)
  fill_in 'title', with: "Event One"
  check 'lighting'
  click_button 'Make Booking Request'
end

def sign_up_admin
  user = User.create('New', 'Admin', 'email2@email.com', '123456', 'notmypassword', 'This is my reason')
  user.status = 'approved'
  user.save!
end

def sign_in_admin
  sign_up_admin
  visit '/'
  fill_in 'email', with: 'email2@email.com'
  fill_in 'password', with: 'notmypassword'
  click_button 'submit'
end
