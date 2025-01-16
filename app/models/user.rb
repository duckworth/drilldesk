class User < ApplicationRecord
  include User::Roles
  include User::Settings

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :lockable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :skip_valid_email

  has_paper_trail only: %i[ email name sys_roles locked_at unconfirmed_email ]
  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :sys_roles, intersection: { within: SYS_ROLES, message: I18n.t("invalid_system_role") }
  validates :email, email: true, unless: ->(u) { u.skip_valid_email }

  scope :enabled, -> { where(disabled_at: nil) }
  def active_for_authentication?
    super && disabled_at.nil?
  end

  def inactive_message
    disabled_at? ? :account_disabled : super
  end
end
