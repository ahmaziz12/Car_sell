class User < ApplicationRecord
  validates :username, length: { minimum:1, maximum: 30}
  validates :phone, numericality: true, length: { minimum: 10, maximum: 15 }, uniqueness: true, allow_blank: true
  validates_format_of :password, with: /^(?=.*?[A-Z])(?=.*?[#?!@$%^&*-]).{8,}$/, multiline: true, message: "(minimum 8 characters with at least one capital letter and a special character)"
  validates :email,  presence: true, if: -> { phone.blank? }
  validates :phone,  presence: true, if: -> { email.blank? }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login

  def login
    @login || self.phone || self.email
  end 

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(phone) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.has_key?(:phone) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  protected
  def email_required?
    true unless phone.present?
  end
  
end
