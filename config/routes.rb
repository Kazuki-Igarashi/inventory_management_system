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
    
    # delete 'shipping_informations/destroy_all' => 'shipping_informations#destroy_all'
    resources :shipping_informations
     
    # get 'shipping_informations/index'
      resources :orders do
        collection do
          post :confirm
          get :completed
        end
      end
      
      resources :companys
      resources :addresses
      resources :items
      resources :receiving_stocks
      resources :genres

      
      
      # public
      # destroy_allのルーティング
       delete 'issues/destroy_all' => 'issues#destroy_all'
      resources :issues
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
