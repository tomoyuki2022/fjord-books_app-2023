Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books do
    scope module: :books do
      resources :comments, only: :create
    end
  end
  resources :reports do
    scope module: :reports do
      resources :comments, only: :create
      resources :mentions, only: %i(create destroy)
      get 'mentioning_reports' => 'mentions#mentioning_reports', as: 'mentioning_reports'
      get 'mentioned_reports' => 'mentions#mentioned_reports', as: 'mentioned_reports'
    end
  end
  resources :comments, only: :destroy
  resources :users, only: %i(index show)
end
