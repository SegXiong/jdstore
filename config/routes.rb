Rails.application.routes.draw do
  devise_for :users

  resources :products do
    member do
      post :add_to_cart
      post :collect
      post :discollect
    end
    collection do
      get :search
    end
    resources :reviews
  end

  namespace :admin do
    resources :products
    resources :categories
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  resources :cart_items do
    member do
      post :add
      post :minus
    end
  end

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
    resources :favorites do
      member do
        post :remove
      end
    end
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
end
