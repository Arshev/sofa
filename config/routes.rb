Rails.application.routes.draw do
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD
  resources :questions do
    resources :answers
  end
=======
  resources :questions
>>>>>>> ae67c860fd7a41df7ec07ce267a0b4026a9bf0f1
end
