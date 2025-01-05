class CustomAdminAuthorization < ActiveAdmin::AuthorizationAdapter
  def authorized?(action, subject = nil)
    user.sys_admin?
  end
end
