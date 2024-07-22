Rails.application.routes.draw do
  devise_for :users,
             controllers: { registrations: 'my_devise/registrations', sessions: 'my_devise/sessions' },
             path: '',
             path_names: { sign_in: 'login', password: 'forgot', confirmation: 'confirm', unblock: 'unblock', sign_up: 'register/user', sign_out: 'logout' }

  devise_scope :user do
    get 'register' => 'my_devise/registrations#choose_register_method'
    get 'register/charity' => 'my_devise/registrations#charity'
    get 'register/corporate' => 'my_devise/registrations#corporate'
  end

  resources :requests
  resources :devise
  root 'requests#index'

  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'profile' => 'profile#index'
  post 'profile/edit' => 'profile#edit'

  post 'requests/apply' => 'requests#apply'

  get 'myrequests' => 'my_requests#index'
  post 'myrequests/complete' => 'my_requests#complete'
  post 'myrequests/accept' => 'my_requests#accept'
  post 'myrequests/reject' => 'my_requests#reject'

  get 'myapplications' => 'my_applications#index'
  post 'myapplications/withdraw' => 'my_applications#withdraw'

  get 'reviews/new' => 'reviews#new'
  get 'reviews/edit' => 'reviews#update'

  post 'notifications/read' => 'notifications#read'
  post 'notifications/clear' => 'notifications#clear'

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
    resources :ban_user, only: [:index] do
      member do
        post :ban
        post :unban
      end
    end

    resources :user_reports, only: [:index, :new, :create]
  end

  get 'admin/login', to: 'admin_sessions#new', as: 'new_admin_session'
  post 'admin/login', to: 'admin_sessions#create', as: 'admin_sessions'
  delete 'admin/logout', to: 'admin_sessions#destroy', as: 'destroy_admin_session'
end
