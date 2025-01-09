class Team < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_paper_trail
  include AASM
  include Team::States

  validates :name, presence: true
  validates :slug, uniqueness: true, format: { with: /\A[a-zA-Z0-9-]+\z/, message: "only allows letters, numbers, and hyphens" },
            length: { minimum: 3, maximum: 39 }
  validates :timezone, presence: true, inclusion: { in: TZInfo::Timezone.all_identifiers }

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
