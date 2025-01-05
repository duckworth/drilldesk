# frozen_string_literal: true

class User
  module Roles
    module SysRole
      SYS_ADMIN = "sys_admin"
    end

    extend ActiveSupport::Concern

    included do
      # Account level roles

      const_set(:SYS_ROLES, [ SysRole::SYS_ADMIN ])

      def sys_admin?
        sys_roles.include?(SysRole::SYS_ADMIN)
      end
    end
  end
end
