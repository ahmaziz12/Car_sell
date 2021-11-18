class AdsController < ApplicationController
  include Pagy::Backend

  before_action :find_user, except: [:index, :new]

  def index
    if params[:ads] == "my_ads"
      @pagy, @ads = pagy(current_user.ads)
     elsif params[:ads] == "fav_ads"
        @favourite_ads = Array.new()
        current_user.favourites.each do |f|
          @favourite_ads << f.ad
        end
        @pagy, @ads = pagy_array(@favourite_ads, items: Ad::ITEMS_PER_PAGE)
    else
      @pagy, @ads = pagy(Ad.all)
    end
  end

  def new
    @ad = Ad.new
  end

  def edit; end

  def create
    @ad = current_user.ads.new(ad_parameter)
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
    if @ad.update(ad_parameter)
      redirect_to after_ad_post_path(:second_step, ad_id: @ad)
    else
      render 'edit'
    end
  end

  def show; end

  def close
    @ad.update(closed: "true")
    redirect_to ads_path
  end

  def open
    @ad.update(closed: "false")
    redirect_to ads_path
  end

  def favourite
    fav = Favourite.new()
    fav.user_id = current_user.id
    fav.ad_id = params[:id]
    if fav.save
      flash[:notice] = "Ad added to Favorites"
    else
      flash[:alert] = "This ad is already marked as favourite"
    end
    redirect_to ads_path
  end

  def unfavourite
    if Favourite.where(ad_id: params[:id]).destroy_all
      flash[:notice] = "Ad removed from Favorites."
    end

    redirect_to ads_path
  end

  private

  def find_user
    @ad = Ad.find(params[:id])
  end

  def ad_parameter
    params.require(:ad).permit(:make, :city, :price, :engine_type, :transmission, :color, :milage, :capacity, :assembly,:featured, :description, :secondary_contact, :color_detail, images: [])
  end
end
