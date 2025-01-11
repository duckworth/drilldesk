Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  ActiveAdmin.routes(self)

  authenticate :user, ->(u) { u.sys_admin? } do
    mount Flipper::UI.app(Flipper) => "/admin/feature-flags"
    mount MissionControl::Jobs::Engine, at: "/admin/mission_control/jobs"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  scope "/t/:team_slug" do
    resources :custom_scenarios
  end

  resources :memberships

  resources :exercise_types, only: [ :index, :show ]
  resources :exercise_objectives, only: [ :index, :show ]
  # Defines the root path route ("/")
  # root "posts#index"
  root to: "pages#home"
end
