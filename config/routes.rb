Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # - Endpoints to: Create/Update/Delete/Index/Show teams
  # - Endpoints to: Create/Update/Delete/Index/Show members
  # - Endpoints to: Create/Update/Delete/Index/Show projects
  # - Endpoint to: Update the team of a member
  # - Endpoint to: Get the members of a specific team
  # - Endpoint to: Add a member to a project
  # - Endpoint to: Get the members of a specific project

  namespace :api do
    namespace :v1 do
      resources :teams do
        get :members, on: :member
      end

      resources :projects do
        get :members, on: :member
        post :add_member, on: :member
      end

      resources :members do
        patch :update_team, on: :member
      end
    end
  end
end
