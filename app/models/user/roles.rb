# frozen_string_literal: true

class User
  module Roles
    module SysRole
      SYS_ADMIN = "sys_admin"
    end

    module Role
      OWNER = "owner"
      MANAGER = "manager"
      PARTICIPANT = "participant"
      VIEWER = "viewer"
    end

    extend ActiveSupport::Concern

    included do
      # Account level roles
      const_set(:ROLES, [
        Role::OWNER,
        Role::MANAGER,
        Role::PARTICIPANT,
        Role::VIEWER
      ])

      # System level roles
      const_set(:SYS_ROLES, [ SysRole::SYS_ADMIN ])

      def sys_admin?
        sys_roles.include?(SysRole::SYS_ADMIN)
      end
    end
  end
end
