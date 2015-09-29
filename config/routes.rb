Hastings::Engine.routes.draw do
  resources :logs, only: [:index] do
    collection do
      get "date/:date" => "logs#date", as: :date
      get "search"
    end
  end

  resources :apps do
    get "search", on: :collection
    get "search_logs", on: :member
    post "log", on: :member
  end

  resources :tasks, path: "/" do
    collection do
      get "search"
    end

    member do
      patch "toggle"
      patch "run_now"
    end

    resources :instances, shallow: true, only: [:show, :index] do
      get "search", on: :member
      resources :logs, only: [:index]
    end
  end
end
