# frozen_string_literal: true

# app/models/concerns/file_constraints.rb
module FileConstraints
  extend ActiveSupport::Concern

  # Constants
  ACCEPTED_FILE_EXTENSIONS = %w[pdf doc docx xls xlsx ppt pptx rtf txt png jpeg jpg gif zip].freeze
  MAX_FILE_SIZE = 25.megabytes

  # Class Methods
  class_methods do
    def accepted_mime_types
      ACCEPTED_FILE_EXTENSIONS.map { |ext| Marcel::MimeType.for(extension: ext) }.compact.map(&:to_s)
    end
  end
end
