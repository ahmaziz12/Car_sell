class AdsController < ApplicationController
  include Pagy::Backend

  before_action :find_ad, except: [:index, :new, :create]

  def index
    if params[:ads] == "my_ads"
      @ads = current_user.ads
    elsif params[:ads] == "fav_ads"
      @ads = current_user.favourite_ads
    else
      @ads = Ad.all
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
    respond_to do |format|
      format.js
      format.html { redirect_to ads_path, notice: 'Post successfully deleted' }
      format.json { head :no_content }
    end
  end

  def update
    if @ad.update(ad_params)
      redirect_to after_ad_post_path(:second_step, ad_id: @ad)
    else
      render 'edit'
    end
  end

  def show; end

  def close
    @ad.update_attribute(:closed, true)
    redirect_back fallback_location: ads_path
  end

  def open
    @ad.update_attribute(:closed, false)
    redirect_back fallback_location: ads_path
  end

  def favourite

    fav = current_user.favourites.build(ad_id: params[:id])
    if fav.save
      flash[:notice] = "Ad added to Favorites"
    else
      flash[:alert] = "This ad is already marked as favourite"
    end
    redirect_back fallback_location: ads_path
  end

  def unfavourite
    favourite_obj = current_user.favourites.find_by_ad_id(params[:id])
    if favourite_obj.present?
      favourite_obj.destroy
      if favourite_obj.destroyed?
        flash[:notice] = "Ad removed from Favorites."
      end
    end
    redirect_back fallback_location: ads_path
  end

  private

  def find_ad
    @ad = Ad.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:make, :city, :price, :engine_type, :transmission, :color, :milage, :capacity, :assembly,:featured, :description, :secondary_contact, :color_detail, images: [])
  end
end
