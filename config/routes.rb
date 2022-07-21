Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :organisations
  resources :organisation_users do
    member do
      post :join
      delete :leave
    end
  end
end
