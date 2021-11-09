class AfterAdPostController < ApplicationController
  include Wicked::Wizard

  steps :second_step, :third_step

  def show
    @ad = Ad.find(params[:ad])
    render_wizard
  end

  def update
      @ad = Ad.find(params[:ad_id])
      case step
        when :second_step
          if ((params[:ad][:images]).present?)
            params[:ad][:images].each do |img|
              @image=Image.new
              @image.image.attach(img)
              if @ad.images.count == 5
                @ad.images.delete(@ad.images.first)
              end
              @ad.images << @image
            end
          end
        when :third_step
          @ad.update_attributes(:secondary_contact, :featured)
      end
      render_wizard(@ad,{},ad: @ad)
  end

  # def pay
  #   @ad.set_payment_processor :braintree
  # end

end
