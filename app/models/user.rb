class User < ApplicationRecord
  include User::Roles

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :skip_valid_email

  has_paper_trail only: %i[ email first_name last_name sys_roles locked_at unconfirmed_email ]
  validates :first_name, presence: true, length: { minimum: 1, maximum: 75 }
  validates :last_name, length: { maximum: 75 }
  validates :sys_roles, intersection: { within: SYS_ROLES, message: I18n.t("invalid_system_role") }
  validates :email, email: true, unless: ->(u) { u.skip_valid_email }

  def name
    [ first_name, last_name ].compact.join(" ")
  end
end
