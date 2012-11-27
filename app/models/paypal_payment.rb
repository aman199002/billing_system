class PaypalPayment
  
  def initialize(subscription)
  	@subscription = subscription
  end

  def checkout_details
  	PayPal::Recurring.new(token: @subscription.paypal_payment_token).checkout_details
  end	

  def checkout_url(options)  	
  	process(:checkout, options).checkout_url
  end	

  def make_recurring
  	process :request_payment
  	process(:create_recurring_profile, {period: :monthly, frequency: 1, start_at: Time.zone.now})
  end

private

  def process(action, options={})
  	options = options.reverse_merge(
  	  :token   => @subscription.paypal_payment_token,
	  :payer_id   => @subscription.paypal_customer_token,
	  :description  => "Awesome - Monthly Subscription",
	  :amount       => "9.00",
	  :currency     => "USD"
  	)  	
  	response = PayPal::Recurring.new(options).send(action)	
	raise response.errors.inspect if response.errors.present?
	response
  end  

end	