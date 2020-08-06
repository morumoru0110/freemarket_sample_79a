Rails.application.routes.draw do
  get 'favs/create'
  get 'favs/destroy'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root "toppages#index"
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :cards, only: [:new, :update, :create, :show , :destroy] 

  resources :products do   
    resources :favs
    collection do
      post 'purchase'
      get 'buy'
      get 'favs'
    end

    
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end

  end 
  resources :users, only: [:index, :new, :edit]
  resources :registration, only: [:index]
end
