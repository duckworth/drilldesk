ActiveAdmin.register Membership do
  # Specify parameters which should be permitted for assignment
  permit_params :team_id, :user_id, :role, :preferences

  # or consider:
  #
  # permit_params do
  #   permitted = [:team_id, :user_id, :role, :preferences]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :team
  filter :user
  filter :role
  filter :preferences
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :team
    column :user
    column :role
    column :preferences
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :team
      row :user
      row :role
      row :preferences
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :team
      f.input :user
      f.input :role
      f.input :preferences
    end
    f.actions
  end
end
