Rails.application.routes.draw do
  devise_for :users,
             controllers: { registrations: 'my_devise/registrations', sessions: 'my_devise/sessions' },
             path: '',
             path_names: { sign_in: 'login', password: 'forgot', confirmation: 'confirm', unblock: 'unblock', sign_up: 'register/user', sign_out: 'logout' }

  resources :requests
  resources :devise
  root 'requests#index'

  devise_scope :user do
    get 'register' => 'my_devise/registrations#choose_register_method'
    get 'register/charity' => 'my_devise/registrations#charity'
    get 'register/corporate' => 'my_devise/registrations#corporate'
    post 'register/corporate' => 'my_devise/registrations#create_corporate'
    post 'register/charity' => 'my_devise/registrations#create_charity'
    get 'register/charitysuccess' => 'my_devise/registrations#charitysuccess'
    get 'register/corporatesuccess' => 'my_devise/registrations#corporatesuccess'
  end

  authenticated :user, lambda { |u| u.role_id == 2 } do
    namespace :admin do
      root 'charities#index', as: :admin_root
    end
  end

  authenticated :user, lambda { |u| u.role_id == 3 } do
    namespace :cvm do
      root 'cvm#index', as: :cvm_root
      get 'charities', to: 'cvm#manage_charities', as: 'charities'
      patch 'charities/update' => 'cvm#update_charities'
      get 'employees' => 'employees#index'
      patch 'employees/deactivate' => 'employees#deactivate'
      patch 'employees/activate' => 'employees#activate'
      post 'summaryreport' => 'cvm#generate_report'
      post 'generatenew' => 'cvm#generate_new_code'
    end
  end

  authenticated :user, lambda { |u| u.role_id == 5 } do
    namespace :charity do
      root 'charity#index', as: :charity_root
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'profile/:id', to: 'profile#index', as: 'user_profile'

  get 'profile', to: 'profile#index'
  get 'profile/edit', to: 'profile#edit'
  patch 'profile', to: 'profile#update'

  post 'requests/apply' => 'requests#apply'

  get 'myrequests' => 'my_requests#index'
  post 'myrequests/complete' => 'my_requests#complete'
  post 'myrequests/accept' => 'my_requests#accept'
  post 'myrequests/reject' => 'my_requests#reject'

  get 'myapplications' => 'my_applications#index'
  post 'myapplications/withdraw' => 'my_applications#withdraw'

  resources :reviews, only: [:edit, :update, :index, :new, :create]

  post 'notifications/read' => 'notifications#read'
  post 'notifications/clear' => 'notifications#clear'

  resources :chats, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end

  namespace :api do
    namespace :v1 do
      resources :requests
    end
    namespace :v2 do
      resources :reviews, :requests
    end
  end

  resources :request_application, path: 'applications' do
    resources :reviews, only: %i[new create edit update]
  end

  namespace :admin do
    resources :approve_companies, only: [:index, :show] do
      member do
        patch :approve
        patch :disable
      end
    end

    resources :charities, only: [:index, :show] do
      member do
        patch :approve
        patch :disable
      end
    end

    resources :ban_user, only: [:index] do
      member do
        post :ban
        post :unban
        post :cancel_ban
      end
    end

    resources :delete_requests, only: [:index, :destroy] do
      member do
        get 'confirm'
      end
    end
  end

  resources :user_reports, only: [:new, :create] do
    collection do
      get 'confirm'
    end
  end

  get 'confirm_report', to: 'user_reports#confirm', as: 'confirm_report'

  get 'admin/login', to: 'admin_sessions#new', as: 'new_admin_session'
  post 'admin/login', to: 'admin_sessions#create', as: 'admin_sessions'
  delete 'admin/logout', to: 'admin_sessions#destroy', as: 'destroy_admin_session'
end
