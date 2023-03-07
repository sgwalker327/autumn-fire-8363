Rails.application.routes.draw do
  resources :plots, only: [:index] do
    resources :plants, only: [:destroy], controller: "plots/plants"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
