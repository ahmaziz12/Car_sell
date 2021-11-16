class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
      @ad= Ad.find(params[:adv])
      current_user.set_payment_processor :stripe
      current_user.payment_processor.payment_method_token = params[:payment_method_token]
      @checkout_session = current_user.payment_processor.checkout(
        mode: "payment",
        line_items: 'price_1Jut0vAfZA0eirmQ4xZHZwBp',
        metadata: { adv: params[:adv] },
        success_url: success_checkouts_url,
        cancel_url: after_ad_post_url(:third_step, adv: @ad)
      )
    end

    def success
      @ad_id = Stripe::Checkout::Session.retrieve(params[:session_id]).metadata.adv
      @ad = set_ad(@ad_id)
      @ad.update(featured: true)
      redirect_to after_ad_post_path(:third_step, adv: @ad), alert: "Your Ad is successfully featured"
    end

    private
    def set_ad(ad_id)
      @ad = current_user.ads.find(ad_id)
    end
  end
