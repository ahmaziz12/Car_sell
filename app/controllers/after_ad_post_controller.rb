class AfterAdPostController < ApplicationController
  include Wicked::Wizard

  steps :second_step, :third_step

  def show
    @ad = Ad.find(params[:ad_id])
    render_wizard
  end

  def update
    @ad = Ad.find(params[:ad_id])
    case step
      when :second_step
        if params.dig(:ad, :images).present?
          @ad.images.attach(params[:ad][:images])
          if @ad.errors[:images].present?
            @ad.reload
            byebug
            redirect_to after_ad_post_path(:second_step, ad_id: @ad), alert: @ad.errors.messages[:images].first
            return
          end
        end
      when :third_step
        if @ad.update_attribute(:secondary_contact, params[:secondary_contact])
          redirect_to @ad and return
        end
      end
    render_wizard(@ad, {}, ad_id: @ad)
  end

  def destroy
    @ad = Ad.find(params[:ad_id])
    @img = @ad.images.find(params[:img])
    @img.purge
    redirect_to after_ad_post_path(:second_step, ad_id: @ad), alert: "Image deleted successfully"
  end

end
