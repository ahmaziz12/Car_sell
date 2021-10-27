class User < ApplicationRecord
  validates :username, length: { maximum: 30}
  validates :phone, numericality: true, length: { minimum: 10, maximum: 15 }, uniqueness: true, allow_blank: true
  validates_format_of :password, with: /^(?=.*?[A-Z])(?=.*?[#?!@$%^&*-]).{8,}$/, multiline: true, message: "(minimum 8 characters with at least one capital letter and a special character)"
  validates :email,  presence: true, if: -> { phone.blank? }
  validates :phone,  presence: true, if: -> { email.blank? }

  protected
  def email_required?
    true unless phone.present?
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  
end
