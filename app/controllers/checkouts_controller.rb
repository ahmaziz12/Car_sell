class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_ad, only: :show

  ITEM = 'price_1Jut0vAfZA0eirmQ4xZHZwBp'

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.payment_method_token = params[:payment_method_token]
    @checkout_session = current_user.payment_processor.checkout(
      mode: "payment",
      line_items: ITEM,
      metadata: { ad_id: params[:ad_id] },
      success_url: success_checkout_url,
      cancel_url: after_ad_post_url(:third_step, ad_id: @ad)
    )
  end

  def success
    @ad_id = Stripe::Checkout::Session.retrieve(params[:session_id]).metadata.ad_id
    set_ad(@ad_id)
    @ad.update(featured: true)
    redirect_to after_ad_post_path(:third_step, ad_id: @ad), notice: "Your Ad is successfully featured"
  end

  private

  def find_ad
    @ad = current_user.ads.find(params[:ad_id]) if params[:ad_id]
    redirect_to ads_path, alert: "No associated ad found" unless @ad
  end

  def set_ad(ad_id)
    @ad = current_user.ads.find(ad_id)
  end
end
