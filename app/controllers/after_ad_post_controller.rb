class AfterAdPostController < ApplicationController
  include Wicked::Wizard

  before_action :find_ad

  steps :second_step, :third_step

  def show
    render_wizard
  end

  def update
    case step
    when :second_step
      if params.dig(:ad, :images).present?
        @ad.images.attach(ad_images_params[:images])
        if @ad.errors[:images].present?
          redirect_to after_ad_post_path(:second_step, ad_id: @ad), alert: @ad.errors.messages[:images].first
          return
        end
      end
    when :third_step
      if @ad.update(ad_secondary_contact_params)
        redirect_to @ad, notice: "Ad saved Successfully" and return
      end
    end
    render_wizard(@ad, {}, ad_id: @ad)
  end

  def destroy
    @img = @ad.images.find(params[:img])
    @img.purge
    redirect_to after_ad_post_path(:second_step, ad_id: @ad), notice: "Image deleted successfully"
  end

  private

  def ad_images_params
    params.require(:ad).permit(images: [])
  end

  def ad_secondary_contact_params
    params.require(:ad).permit(:secondary_contact)
  end

  def find_ad
    @ad = Ad.find(params[:ad_id])
  end
end
