Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    post "/comments", to: "user_comments#create"
    delete "/comments/:id", to: "user_comments#destroy"
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals do
    post "/comments", to: "goal_comments#create"
    delete "/comments/:id", to: "goal_comments#destroy"
  end
end
