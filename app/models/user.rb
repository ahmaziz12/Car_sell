class User < ApplicationRecord
  pay_customer

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login
  has_many :ads

  PASSWORD_REGEX = /\A(?=.*?[A-Z])(?=.*?[#?!@$%^&*-]).{8,}\z/
  PK_PHONE_REGEX = /^((\+92))-{0,1}\d{3}-{0,1}\d{7}$/

  validates :username, length: { minimum:1, maximum: 30}
  validates :phone, format: {with: PK_PHONE_REGEX, message: "format should be +92-3XX-XXXXXXX", multiline: true}, uniqueness: true, allow_blank: true
  validates :password, format: {with: PASSWORD_REGEX, message: "(minimum 8 characters with at least one capital letter and a special character)"}, allow_blank: true
  validates :email,  presence: true, if: -> { phone.blank? }
  validates :phone,  presence: true, if: -> { email.blank? }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(phone) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.has_key?(:phone) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def login
    @login || self.phone || self.email
  end 

  protected

  def email_required?
    true unless phone.present?
  end
end
