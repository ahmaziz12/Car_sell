class Ad < ApplicationRecord
  # include PgSearch::Model
  #   multisearchable against: [:make, :city, :price, :engine_type, :transmission, :color, :milage, :capacity, :assembly]

  CITIES = ["Rawalpindi" , "Lahore" , "Quetta", "Karachi", "Peshawar", "Islamabad"]
  MAKE = ["Suzuki", "Toyota", "Honda", "BMW"]
  ENGINE_TYPE = ["Patrol", "Diesel", "Hybrid"]
  TRANSMISSION = ["Manual", "Automatic"]
  COLOR = ["Black", "White","Other"]
  ASSEMBLY = ["Local", "Imported"]
  PK_PHONE_REGEX = /^((\+92))-{0,1}\d{3}-{0,1}\d{7}$/
  FLOAT_REGEX = /((\d*\.)?\d+)/


  has_rich_text :description
   has_many_attached :images

  validates :city, inclusion: { in: CITIES, message: "%{value} is invalid" }
  validates :make, inclusion: { in: MAKE, message: "%{value} is invalid" }
  validates :transmission, inclusion: { in: TRANSMISSION, message: "%{value} is invalid" }
  validates :engine_type, inclusion: { in: ENGINE_TYPE, message: "%{value} is invalid" }
  validates :color, presence: true
  validates :assembly, inclusion: { in:  ASSEMBLY, message: "%{value} is invalid" }
  validates :secondary_contact, format: {with: PK_PHONE_REGEX, message: "format should be +92-3XX-XXXXXXX", multiline: true}
  validates :milage, format: {with: FLOAT_REGEX, message: "Please Enter only numbers", multiline: true}, presence: true
  validates :price, format: {with: FLOAT_REGEX, message: "Please Enter only numbers" , multiline: true}
  validates :capacity,format: {with: FLOAT_REGEX, message: "Please Enter only numbers" , multiline: true}, presence: true

 

end