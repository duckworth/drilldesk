module TeamControllerMethods
  extend ActiveSupport::Concern

  included do
    include ActsAsTenant::ControllerExtensions::Filter

    def set_team_and_membership
      return handle_unauthenticated_user! unless current_user

      @membership = if session[:current_team_id].present?
                      # Load a specific membership and associated team from the session team_id
                      current_user.memberships.includes(:team).find_by(team_id: session[:current_team_id])
      else
                      # Lazy-load user's memberships with their associated teams
                      memberships = current_user.memberships.includes(:team).limit(2).to_a

                      if memberships.size == 1
                        # If the user has exactly one membership, use it
                        session[:current_team_id] = memberships.first.team_id
                        memberships.first
                      else
                        # Redirect if no session is set and multiple teams exist
                        return redirect_to choose_team_path
                      end
      end

      return handle_unauthorized_team! unless @membership

      # Populate necessary instance variables and tenant context
      @team = @membership.team
      set_current_tenant(@team)
      Current.team = @team
      Current.membership = @membership
      Current.user = current_user
    end

    def handle_unauthenticated_user!
      # Handle the edge case where the user is not authenticated
      flash[:alert] = "You must be signed in to access this page."
      redirect_to new_user_session_path
    end
    def handle_unauthorized_team!
      # Handle the edge case where the specified team is invalid or unauthorized
      flash[:alert] = "You are not authorized or the selected team does not exist."
      logger.warn "User #{current_user&.id} attempted to access team (id=#{session[:current_team_id]}) without permission."
      session[:current_team_id] = nil
      redirect_to root_path
    end
    def reset_current
      Current.user = nil
      Current.team = nil
      Current.membership = nil
    end
  end
end
