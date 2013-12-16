Incubator::Application.routes.draw do
  resources :tasks

  get "home/index"

  root to: "home#index"
end
