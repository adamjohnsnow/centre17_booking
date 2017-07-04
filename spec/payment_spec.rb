describe Payment do

    scenario 'create payment' do
      Payment.create(
          user_id: 1,
          cash_payment: 100.25,
          time_payment: 0,
          date_time: DateTime.now()
          )
      expect(Payment.all.count).to eq 1
    end

end
