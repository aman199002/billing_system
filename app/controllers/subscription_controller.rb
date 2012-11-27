class SubscriptionController < ApplicationController

  def new
  	@subscription = Subscription.new
  	if params[:PayerID]
  	  @subscription.paypal_customer_token = params[:PayerID]
  	  @subscription.paypal_payment_token = params[:token]  	  
      @subscription.email = @subscription.paypal.checkout_details.email
  	end	
  end

  def create    
  	@subscription = Subscription.new(params[:subscription])
  	if @subscription.save_with_payment
  	  redirect_to @subscription, :notice => "Thanks"	  	  
  	else
  	  render :new	
  	end	
  end	

  def show
  	@subscription = Subscription.find(params[:id])
  end	

  def paypal_checkout
  	subscription = Subscription.new
  	redirect_to subscription.paypal.checkout_url(:return_url => new_subscription_url,:cancel_url => root_url)
  end
  
end
