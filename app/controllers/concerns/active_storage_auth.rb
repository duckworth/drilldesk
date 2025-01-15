module ActiveStorageAuth
  extend ActiveSupport::Concern

  included do
    include TeamControllerMethods
    include Devise::Controllers::Helpers
    before_action :set_team_and_membership, prepend: true
    before_action :authenticate_user!, prepend: true

    def handle_unauthenticated_user!
      # puts  "ActiveStorageAuth User is not authenticated!"
      logger.warn "ActiveStorageAuth User is not authenticated!"
      head :unauthorized
    end
    def handle_unauthorized_team!
      # puts  "ActiveStorageAuth User is not authorized!"
      logger.warn "ActiveStorageAuth Team is not authorized!"
      head :unauthorized
    end
  end

  # def authenticate_user!
  #   puts "calling ActiveStorageAuth authenticate_user! for request: #{request.path}"
  #   super
  # end
end
