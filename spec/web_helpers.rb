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

def create_some_slots
  Slot.open_dates('05/07/2017', '05/08/2017')
end

def create_two_day_slots
  Slot.open_dates('01/08/2017', '02/08/2017')
end

def book_one_slot
  slot = Slot.get(2)
  slot.update(status: 'booked', booking_id: 1)
  slot.save!
end
