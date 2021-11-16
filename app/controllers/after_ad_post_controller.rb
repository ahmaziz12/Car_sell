class AfterAdPostController < ApplicationController
  include Wicked::Wizard

  steps :second_step, :third_step

  def show
    @ad = Ad.find(params[:adv])
    render_wizard
  end

  def update
      @ad = Ad.find(params[:adv])
      case step
        when :second_step
          if ((params[:ad]).present?)
            if ((params[:ad][:images].count + @ad.images.count) <= 5)
              @ad.images.attach(params[:ad][:images])
              render_wizard(@ad,{},adv: @ad)
            else
              redirect_to after_ad_post_path(:second_step, adv: @ad), alert: "maximum 5 images can be attatched"
            end
          else
            render_wizard(@ad,{},adv: @ad)
          end
        when :third_step
          if @ad.update_attribute(:secondary_contact, params[:secondary_contact])
            redirect_to @ad
          else
            render_wizard(@ad,{},adv: @ad)
          end
      end
  end

  def destroy
    @ad = Ad.find(params[:adv])
    @img = @ad.images.find(params[:img])
    @img.purge
    redirect_to after_ad_post_path(:second_step, adv: @ad), alert: "Image deleted successfully"
  end

end