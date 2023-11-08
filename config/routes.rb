Rails.application.routes.draw do
 

 

  
  namespace :admin do
    resources :orders
    # get 'orders/index'
    # get 'orders/show'
    resources :contractors
    # get 'contractors/index'
    # get 'contractors/show'
    # get 'contractors/edit'
  
    resources :genres
    # get 'genres/index'
    # get 'genres/edit'
    # get 'genres/_form'
  
  
    root :to => 'homes#top'
  end
  
  scope module: :public do
     
  resources :users do
    collection do
      get 'search'
    end
  end
     
    root :to => "homes#top"
    #home/
    get 'home/about' => 'homes#about', as: 'about'
    
    get 'initial_invoice/show' => 'initial_invoices#show', as: 'show'
    
    delete 'shipping_informations/destroy_all' => 'shipping_informations#destroy_all'
    resources :shipping_informations
     
    # get 'shipping_informations/index'
      resources :orders
      # get 'orders/new'
      # get 'orders/confirm'
      # get 'orders/completed'
      # get 'orders/index'
      # get 'orders/show'
      
      resources :addresses
        # get 'addresses/index'
        # get 'addresses/edit'
      
      
      # public
       delete 'issues/destroy_all' => 'issues#destroy_all'
      resources :issues
      
      get 'orders/thanks' => 'orders#thanks'
      post 'orders/confirm' => 'orders#confirm'
      # get 'issues/show'
      # public/
      # resources :receiving
      # get 'receiving/_stocks'
      # get 'receiving/index'
      # get 'receiving/show'
      # get 'receiving/search'
      
      # public
      resources :contractors, only: [:update] do
      collection do                                           # resourcesで定義されるアクション以外を追加する(URIにidを挟まない場合はcollection)
         # quitのルーティング
        get "quit"                                           
        # mypageのルーティング
        get "mypage" => 'contractors#show'                      
        get "edit" => "contractors#edit"
      end
      member do
        # resourcesで定義されるアクション以外を追加する(URIにidを挟む場合はmember)
        # 論理削除用のルーティング
        patch "withdraw" => "contractors#withdraw"              
      end
    end
        
      # get 'contractors/show'
      # get 'contractors/edit'
      # get 'contractors/quit'
      # get 'contractors/out'
  
      resources :items
      # get 'items/index'
      # get 'items/show'
      
      resources :receiving_stocks
      # get 'receiving_stocks/index'
      # get 'receiving_stocks/show'
      # get 'receiving_stocks/new'
      # get 'receiving_stocks/edit'
       resources :genres
        # get 'genres/index'
        # get 'genres/edit'
        # get 'genres/_form'
 
      
    end
    namespace :public do
      # get 'homes/top'
      # get 'homes/about'
    end
   
    # devise_for :customers
    # 顧客用
      devise_for :customers,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    
    # devise_for :admins
    # 管理者用
    # URL /admin/sign_in ...
     devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }
    
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
