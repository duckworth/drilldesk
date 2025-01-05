class User < ApplicationRecord
  include User::Roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :lockable, 
         :recoverable, :rememberable, :validatable, :confirmable,
         authentication_keys: [ :email ]

  attr_accessor :skip_valid_email

  validates :first_name, presence: true, length: { minimum: 1, maximum: 75 }
  validates :last_name, length: { maximum: 75 }
  validates :sys_roles, intersection: { within: SYS_ROLES, message: I18n.t("invalid_system_role") }
  validates :email, email: true, unless: ->(u) { u.skip_valid_email }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)&.downcase
    find_by(email: email)
  end
end

