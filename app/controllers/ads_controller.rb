class AdsController < ApplicationController
  def index
    @ads= Ad.all
  end

  def new
    @ad = Ad.new
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def create
    @ad = Ad.new(ad_parameter)
    if @ad.save
      redirect_to after_ad_post_path(:second_step, ad: @ad)
    else
      render 'new'
    end
  end

  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to ads_path, notice: 'Post successfully deleted' }
      format.json { head :no_content }
    end
  end

  def update
    @ad = Ad.find(params[:id])
    if @ad.update(ad_parameter)
      redirect_to @ad
    else
      render 'edit'
    end
  end

  def show
    @ad = Ad.find(params[:id])
  end

  private

  def ad_parameter
    params.require(:ad).permit(:make, :city, :price, :engine_type, :transmission, :color, :milage, :capacity, :assembly,:featured, :description, :secondary_contact, :color_detail, images: [])
  end
end
