class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_paper_trail
  include AASM
  include Team::States

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :custom_scenarios, dependent: :destroy

  validates :name, presence: true
  validates :slug, uniqueness: true, format: { with: /\A[a-zA-Z0-9-]+\z/, message: "only allows letters, numbers, and hyphens" },
            length: { minimum: 3, maximum: 75 }
  validates :timezone, presence: true, inclusion: { in: TZInfo::Timezone.all_identifiers }

  def to_s
    slug
  end
  private

  # def generate_slug
  # remove common suffixes, prefixes, and special characters etc......
  #   name.to_s.parameterize.downcase ....
  # end
  #
  # def generate_unique_slug(base_slug)
  #   slug_candidate = base_slug
  #   count = 1
  #   while Team.exists?(slug: slug_candidate)
  #     slug_candidate = "#{base_slug}-#{count}"
  #     count += 1
  #   end
  #   slug_candidate
  # end
end
