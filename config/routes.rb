Rails.application.routes.draw do
  root to: "posts#index"
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }


  devise_scope :user do
    get '/users/sign_out', to: 'users/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
end
