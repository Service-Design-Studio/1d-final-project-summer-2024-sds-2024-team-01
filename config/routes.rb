Rails.application.routes.draw do
  devise_for :users,
             controllers: { registrations: 'my_devise/registrations', sessions: 'my_devise/sessions' },
             path: '',
             path_names: { sign_in: 'login', password: 'forgot', confirmation: 'confirm', unblock: 'unblock', sign_up: 'register/user', sign_out: 'logout' }

  devise_scope :user do
    get 'register' => 'my_devise/registrations#choose_register_method'
    get 'register/charity' => 'my_devise/registrations#charity'
    get 'register/corporate' => 'my_devise/registrations#corporate'
    post 'register/corporate' => 'my_devise/registrations#create_corporate'
    post 'register/charity' => 'my_devise/registrations#create_charity'
  end

  namespace :admin do
    resources :companies, only: [:index, :show] do
      member do
        post 'approve'
        post 'reject'
      end
    end

    resources :ban_user, only: [:index] do
      member do
        patch 'ban'
        patch 'unban'
        patch 'cancel_ban'
      end
    end
  end

  # Regular company routes
  resources :companies, only: [:index, :show]

  resources :requests
  post 'requests/apply' => 'requests#apply'

  root 'requests#index'

  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'profile' => 'profile#index'
  get 'profile/:id' => 'profile#index', as: 'user_profile'
  post 'profile/edit' => 'profile#edit'

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

  resources :user_reports, only: [:index, :new, :create]

  get 'admin/login', to: 'admin_sessions#new', as: 'new_admin_session'
  post 'admin/login', to: 'admin_sessions#create', as: 'admin_sessions'
  delete 'admin/logout', to: 'admin_sessions#destroy', as: 'destroy_admin_session'
end
