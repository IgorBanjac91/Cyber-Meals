class CheckoutController < ApplicationController
  
  def create 
    @session = Stripe::Checkout::Session.create({
      #customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      allow_promotion_codes: true,
      line_items: @order,
      mode: 'payment',
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url,
    })
    respond_to do |format| 
      format.js
    end
  end

  def success

  end

  def cancel
    
  end
end