Application.routes.draw do
  root "tasks#index"

  devise_for :users

  resources :logs, only: [:index] do
    get "search", on: :collection
  end

  resources :apps do
    get "search", on: :collection
    get "search_logs", on: :member
    post "log", on: :member
  end

  resources :tasks, path: "/" do
    collection do
      get "search"
      get "events"
    end

    member do
      patch "toggle"
      patch "run_now"
    end
  end
end
