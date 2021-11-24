class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_ad, only: :destroy

  def create
    favourite_obj = current_user.favourites.build(ad_id: params[:ad_id])
    if favourite_obj.save
      flash[:notice] = "Ad added to Favorites"
    else
      flash[:alert] = "This ad is already marked as favourite"
    end
    redirect_back fallback_location: ads_path
  end

  def destroy
    @favourite_obj.destroy
    if @favourite_obj.destroyed?
      flash[:notice] = "Ad removed from Favorites."
    end
    redirect_back fallback_location: ads_path
  end

  private

  def find_ad
    @favourite_obj = current_user.favourites.find_by(ad_id: params[:ad_id])
    if @favourite_obj.nil?
      flash[:alert] = "This ad was not in favourites"
      redirect_back fallback_location ads_path
    end
  end
end
