class Subscription < ActiveRecord::Base
  attr_accessible :email, :paypal_customer_token, :paypal_recurring_profile_token, :paypal_payment_token
  attr_accessor :paypal_payment_token

  validates :email, presence: true

  def save_with_payment
  	if valid?
  	  if paypal_payment_token.present?
  	  	save_with_paypal_payment
  	  end	
  	end	
  end	

  def paypal
  	PaypalPayment.new(self)
  end 

  def save_with_paypal_payment
  	response = paypal.make_recurring
  	self.paypal_recurring_profile_token = response.profile_id
  	save!
  end	
end
