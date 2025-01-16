# app/policies/application_policy.rb
class ApplicationPolicy
  attr_reader :user, :record, :team, :membership

  def initialize(user, record)
    @user = user
    @record = record

    @team = Current.team
    @membership = Current.membership
  end

  #
  # Permission checks
  #

  def index?
    false
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  #
  # Role checks (common for all policies)
  #

  def logged_in?
    user.present?
  end

  def tenant_member?
    membership.present?
  end

  def owner?
    membership&.role == User::Roles::Role::OWNER
  end

  def manager?
    [ User::Roles::Role::OWNER, User::Roles::Role::MANAGER ].include?(membership&.role)
  end

  def participant?
    [ User::Roles::Role::OWNER, User::Roles::Role::MANAGER, User::Roles::Role::PARTICIPANT ].include?(membership&.role)
  end

  def viewer?
    [ User::Roles::Role::OWNER, User::Roles::Role::MANAGER, User::Roles::Role::PARTICIPANT, User::Roles::Role::VIEWER ].include?(membership&.role)
  end

  def sys_user?
    user.sys_roles.any? { |role| User::Roles::SysRole.constants.map { |c| User::Roles::SysRole.const_get(c) }.include?(role) }
  end

  #
  # Policy Scope
  #

  class Scope
    attr_reader :user, :scope, :team, :membership

    def initialize(user, scope)
      @user = user
      @scope = scope
      @team = ActsAsTenant.current_tenant
      @membership = Current.membership
    end

    # Default: restrict records to the current tenant
    # You can customize further based on role if needed.
    def resolve
      scope.where(team_id: team.id) if team
    end
  end
end
