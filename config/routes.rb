Rails.application.routes.draw do
  namespace :admin do
    resources :orders
    # get 'orders/index'
    # get 'orders/show'
    resources :contractors
    # get 'contractors/index'
    # get 'contractors/show'
    # get 'contractors/edit'
  
    root :to => 'homes#top'
  end
  
  scope module: :public do
     
    root :to => "homes#top"
    #home/
    get 'home/about' => 'homes#about', as: 'about'
    
    get 'initial_invoice/show' => 'initial_invoices#show', as: 'show'
  
      resources :orders
      # get 'orders/new'
      # get 'orders/confirm'
      # get 'orders/completed'
      # get 'orders/index'
      # get 'orders/show'
      
      # public
      get 'issues/show'
      # public/
      resources :receiving
      # get 'receiving/_stocks'
      # get 'receiving/index'
      # get 'receiving/show'
      # get 'receiving/search'
      
      # public
      resources :contractors
      # get 'contractors/show'
      # get 'contractors/edit'
      # get 'contractors/quit'
      # get 'contractors/out'
  
      resources :items
      # get 'items/index'
      # get 'items/show'
    end
    namespace :public do
      # get 'homes/top'
      # get 'homes/about'
    end
    # devise_for :admins
    # devise_for :customers
    # 顧客用
      devise_for :customers,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    
    # 管理者用
    # URL /admin/sign_in ...
     devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }
    
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
