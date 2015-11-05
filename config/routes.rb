Application.routes.draw do
  root "tasks#index"

  devise_for :users

  resources :logs, only: [:index] do
    get "search", on: :collection
  end

  resources :apps do
    post "log", on: :member
  end

  resources :tasks, path: "/" do
    # get "events", on: :collection

    member do
      patch "toggle"
      patch "run_now"
    end
  end
end
