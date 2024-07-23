Rails.application.routes.draw do
  devise_for :users,
             controllers: { registrations: 'my_devise/registrations', sessions: 'my_devise/sessions' }, path: '', path_names: { sign_in: 'login', password: 'forgot', confirmation: 'confirm', unblock: 'unblock', sign_up: 'register/user', sign_out: 'logout' }

  # ,path: "", controllers: {sessions: "sessions", registrations:"registrations"}, path_names: {sign_in: 'login', password: 'forgot', confirmation: 'confirm', unblock: 'unblock', sign_up: 'register', sign_out: 'logout'}
  resources :requests
  resources :devise
  root 'requests#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  devise_scope :user do
    get 'register' => 'my_devise/registrations#choose_register_method'
    get 'register/charity' => 'my_devise/registrations#charity'
    get 'register/corporate' => 'my_devise/registrations#corporate'
    post 'register/corporate' => 'my_devise/registrations#create_corporate'
    post 'register/charity' => 'my_devise/registrations#create_charity'
  end

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

  resources :reviews, only: [:edit, :update, :index, :new, :create]

  # get 'reviews/new_temp' => 'reviews#new_temp'
  # get 'reviews/new' => 'reviews#new'
  # get 'reviews/edit' => 'reviews#update'

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
end
