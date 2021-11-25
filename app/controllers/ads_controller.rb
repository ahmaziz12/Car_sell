class AdsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, except: [:index, :show, :contact_details]
  before_action :store_location, only: [:contact_details]
  before_action :authenticate!, only: [:contact_details]
  before_action :find_ad, except: [:index, :new, :create]
  before_action :verify_owner, only: [:destroy, :update, :activate, :deactivate, :edit]

  def index
    if params[:ads] == "my_ads"
      @ads = current_user.ads
    elsif params[:ads] == "fav_ads"
      @ads = current_user.favourite_ads
    else
      @ads = Ad.active_ads
    end
    @pagy, @ads = pagy(@ads)
  end

  def new
    @ad = Ad.new
  end

  def edit; end

  def create
    @ad = current_user.ads.new(ad_params)
    if @ad.save
      redirect_to after_ad_post_path(:second_step, ad_id: @ad)
    else
      render 'new'
    end
  end

  def destroy
    @ad.destroy
    redirect_to ads_path, notice: 'Post successfully deleted'
  end

  def update
    if @ad.update(ad_params)
      redirect_to after_ad_post_path(:second_step, ad_id: @ad)
    else
      render 'edit'
    end
  end

  def show; end

  def deactivate
    @ad.update_attribute(:closed, true)
    redirect_back fallback_location: ads_path
  end

  def activate
    @ad.update_attribute(:closed, false)
    redirect_back fallback_location: ads_path
  end

  def contact_details
    respond_to do |format|
      format.js
      format.html { redirect_to @ad}
    end
  end

  private

  def authenticate!
    unless user_signed_in?
      flash[:alert] = "You need to sign in or sign up before continuing."
      render :js => "window.location = '#{new_user_session_path}'"
    end
  end

  def find_ad
    @ad = Ad.find_by(id: params[:id])
    redirect_to root_path, alert: "Ad not found" unless @ad
  end

  def verify_owner
    redirect_to root_path, alert: "This ad does not belongs to you" if current_user != @ad.user
  end

  def ad_params
    params.require(:ad).permit(:make, :city, :price, :engine_type, :transmission, :color, :milage, :capacity, :assembly,:featured, :description, :secondary_contact, :color_detail, images: [])
  end
end
