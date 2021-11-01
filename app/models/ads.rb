class Ad < ApplicationRecord
  include PgSearch::Model
    multisearchable against: [:make, :city, :price, :engine_type, :transmission, :color, :milage, :capacity, :assembly]
    # pg_search_scope :advvanced_search, against: [:make, :city, :price, :engine_type, :transmission, :color, :milage, :capacity, :assembly]
  CITIES = ["Rawalpindi" , "Lahore" , "Quetta", "Karachi", "Peshawar", "Islamabad"]
end