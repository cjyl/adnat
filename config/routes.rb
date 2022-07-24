Rails.application.routes.draw do
  devise_for :users
  get :home, to: "pages#home"
  root to: "organisations#index"
  resources :organisations do
    resources :organisation_users do
      resources :shifts
    end
  end
  resources :organisation_users do
    member do
      post :join
      delete :leave
    end
  end
end
