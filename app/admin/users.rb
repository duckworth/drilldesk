ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :disabled_at
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :disabled_at, as: :boolean, label: "Disabled", collection: [ [ "Yes", true ], [ "No", false ] ]

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  action_item :enable, only: :show do
    link_to "Enable User", enable_admin_user_path(user), method: :put if user.disabled_at?
  end

  action_item :disable, only: :show do
    link_to "Disable User", disable_admin_user_path(user), method: :put unless user.disabled_at?
  end

  member_action :enable, method: :put do
    resource.update(disabled_at: nil)
    redirect_to resource_path, notice: "User enabled"
  end

  member_action :disable, method: :put do
    resource.update(disabled_at: Time.current)
    redirect_to resource_path, notice: "User disabled"
  end
end
