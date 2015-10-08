Application.routes.draw do
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
      get "events"
    end

    member do
      patch "toggle"
      patch "run_now"
    end

    resources :instances, shallow: true, only: [:show, :index] do
      get "search", on: :collection
      resources :logs, only: [:index]
    end
  end
end
