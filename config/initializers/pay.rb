Pay.setup do |config|
  # For use in the receipt/refund/renewal mailers
  config.business_name = "FireWheels"
  config.business_address = "Square63, 34-XX DHA Phase 3, Lahore, Pakistan"
  config.application_name = "FireWheels"
  config.support_email = "ahmed.aziz@square63.org"

  config.send_emails = true

  config.default_product_name = "default"
  config.default_plan_name = "default"

  config.automount_routes = true
  config.routes_path = "/pay" # Only when automount_routes is true
end

