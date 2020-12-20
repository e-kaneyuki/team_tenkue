Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :post
  root to: "posts#index"


  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    # delete 'logout'  => 'sessions#destroy'
    delete 'users/guest_logout', to: 'users/sessions#destroy'
  end
end
