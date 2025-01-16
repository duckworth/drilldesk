class PredefinedPolicy < ApplicationPolicy
  # Define permissions specific to predefined_scenarios

  def create?
    sys_user?
  end

  def update?
    sys_user?
  end

  def destroy?
    sys_user?
  end

  # Optionally, you can control who can view (index/show) predefined_scenarios
  def show?
    true # Allow all users or specify a condition as needed
  end

  def index?
    true # Allow all users or specify a condition as needed
  end

  # Define the policy scope (optional)
  class Scope < Scope
    def resolve
      scope.all # Customize scope as necessary
    end
  end
end
