Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    root to: 'dashboards#show'
  end

  root to: 'homes#show'

  resource :search, only: %i[show]

  post 'text_shouts' => 'shouts#create', defaults: { content_type: TextShout }
  post 'photo_shouts' => 'shouts#create', defaults: { content_type: PhotoShout }

  resources :shouts, only: %i[show] do
    member do
      post 'like' => 'likes#create'
      delete 'unlike' => 'likes#destroy'
    end
  end

  resources :hashtags, only: %i[show]
  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource :session, only: [:create]

  resources :users, only: %i[create show] do
    resources :followers, only: %i[index]
    member do
      post 'follow' => 'followed_users#create'
      delete 'unfollow' => 'followed_users#destroy'
    end
    resource :password,
             controller: 'clearance/passwords',
             only: %i[edit update]
  end

  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'users#new', as: 'sign_up'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
