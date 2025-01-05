class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(_auth_object = nil)
    authorizable_ransackable_attributes.reject { |column| column.match?(/encrypted_password|secret/i) } if Current.in_active_admin
  end

  def self.ransackable_associations(_auth_object = nil)
    authorizable_ransackable_associations if Current.in_active_admin
  end
end
