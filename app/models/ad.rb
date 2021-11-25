class Ad < ApplicationRecord

  CITIES = ["Rawalpindi" , "Lahore" , "Quetta", "Karachi", "Peshawar", "Islamabad"].freeze
  MAKE = ["Suzuki", "Toyota", "Honda", "BMW"].freeze
  ENGINE_TYPE = ["Patrol", "Diesel", "Hybrid"].freeze
  TRANSMISSION = ["Manual", "Automatic"].freeze
  COLOR = ["Black", "White","Other"].freeze
  ASSEMBLY = ["Local", "Imported"].freeze
  PK_PHONE_REGEX = /^(\+92)-{0,1}\d{3}-{0,1}\d{7}$/.freeze
  ITEMS_PER_PAGE = 10.freeze

  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  belongs_to :user
  has_many_attached :images
  has_rich_text :description

  scope :active_ads, -> { where(closed: [nil, false]) }

  validates :images, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'], limit: { max: 5, message: "Maximum 5 images can be attatched" }
  validates :city, inclusion: { in: CITIES }
  validates :make, inclusion: { in: MAKE }
  validates :transmission, inclusion: { in: TRANSMISSION }
  validates :engine_type, inclusion: { in: ENGINE_TYPE }
  validates :color, presence: true
  validates :assembly, inclusion: { in:  ASSEMBLY }
  validates :secondary_contact, format: { with: PK_PHONE_REGEX, message: "format should be +92-3XX-XXXXXXX", multiline: true }, allow_blank: true
  validates :milage, numericality: { only_integer: false }, presence: true
  validates :price, numericality: { only_integer: false }, presence: true
  validates :capacity, numericality: { only_integer: false }, presence: true

end
