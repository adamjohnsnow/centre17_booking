def sign_up
  user = User.create('Mister', 'Something', 'email@email.com', '123456', 'notmypassword', 'This is my reason')
  user.status = 'approved'
  user.save!
end

def sign_in
  visit '/'
  fill_in 'email', with: 'email@email.com'
  fill_in 'password', with: 'notmypassword'
  click_button 'submit'
end

def create_some_slots
  Slot.open_dates('05/07/2017', '05/08/2017')
end

def create_two_day_slots
  Slot.open_dates('01/08/2017', '02/08/2017')
end

def book_one_slot
  slot = Slot.get(2)
  slot.update(status: 'booked')
  slot.save!
end

def do_search
  sign_up
  sign_in
  click_button 'Request New Booking'
  fill_in 'date', with: '07/07/2017'
  fill_in 'duration', with: 3
  check 'afternoon'
  click_button 'Start search'
end

def sign_up_admin
  user = User.create('New', 'Admin', 'email2@email.com', '123456', 'notmypassword', 'This is my reason')
  user.status = 'approved'
  user.save!
end
