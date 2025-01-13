class User
  module Settings
    extend ActiveSupport::Concern

    included do
      # typed_store :settings, coder: ActiveRecord::TypedStore::IdentityCoder do |s|
      #   # examples:
      #   # s.datetime :publish_at
      #   # s.integer :age, null: false
      #   #
      #   # s.boolean :public, default: false, null: false
      #   # # You can define array attributes like in rails 4 and postgres
      #   # s.string :tags, array: true, default: [], null: false
      #   #
      #   # # In addition to prevent null values you can prevent blank values
      #   # s.string :title, blank: false, default: 'Title'
      #   #
      #   # # If you don't want to enforce a datatype but still like to have default handling
      #   # s.any :source, blank: false, default: 'web'
      # end
    end
  end
end
