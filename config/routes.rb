Hastings::Engine.routes.draw do
  resources :logs, only: [:index] do
    collection do
      get 'errors'
      get 'date/:date' => 'logs#date', as: :date
    end
  end

  resources :tasks, path: '/' do
    collection do
      # post 'log'
      get 'search'
    end

    patch 'toggle', on: :member

    resources :instances, shallow: true, only: [:show, :index] do
      resources :logs, only: [:index]
    end
  end
end
