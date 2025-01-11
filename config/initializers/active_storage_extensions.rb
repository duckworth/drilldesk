Rails.application.config.to_prepare do
  # Extend ActiveStorage::Blob
  ActiveStorage::Blob.class_eval do
    belongs_to :team, optional: true
    acts_as_tenant(:team)
  end

  # Extend ActiveStorage::Attachment
  ActiveStorage::Attachment.class_eval do
    belongs_to :team, optional: true
    acts_as_tenant(:team)
  end

  ActiveStorage::VariantRecord.class_eval do
    belongs_to :team, optional: true
    acts_as_tenant(:team)
  end
end
