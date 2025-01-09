ActiveAdmin.register Team do
  # Specify parameters which should be permitted for assignment
  permit_params :name, :slug, :status, :is_test, :timezone, :disabled_at, :suspended_at

  # or consider:
  #
  # permit_params do
  #   permitted = [:name, :slug, :status, :is_test, :timezone, :disabled_at, :suspended_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def find_resource
      Team.friendly.find(params[:id])
    end
  end
  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :name
  filter :slug
  filter :status
  filter :is_test
  filter :timezone
  filter :disabled_at
  filter :suspended_at
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    column :name do |team|
      link_to team.name, admin_team_path(team)
    end
    column :slug
    column :status
    column :is_test
    column :created_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :name
      row :slug
      row :status
      row :is_test
      row :timezone
      row :disabled_at
      row :suspended_at
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :name
      f.input :slug
      f.input :status
      f.input :is_test
      f.input :timezone
      f.input :disabled_at
      f.input :suspended_at
    end
    f.actions
  end
end
