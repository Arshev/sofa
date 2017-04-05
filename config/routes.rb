Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}
  root 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  concern :votable do
    member do
      patch :vote_up
      patch :vote_down
    end
  end

  concern :commentable do
    resources :comments, only: [:create, :destroy]
  end

  resources :questions, concerns: [:votable, :commentable] do
    resources :answers, concerns: [:votable, :commentable], shallow: true do
      patch :best, on: :member
    end
    resources :subscriptions, only: [:create, :destroy], shallow: true
  end
  resources :attachments, only: [:destroy]

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
        get :list, on: :collection
      end
      resources :questions, only: [:index, :show, :create] do
        resources :answers, only: [:index, :show, :create], shallow: true
      end
    end
  end
  
  mount ActionCable.server => '/cable'
  
end
