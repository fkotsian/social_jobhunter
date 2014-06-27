Rails.application.routes.draw do


  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get '/feed', to: 'job_applications#index', as: 'feed'
  scope :user do
    get '/feed', to: 'job_applications#user_apps', as: 'user_feed'
    resources :job_applications, except: [:index], as: 'applications'
    resources :jobs, except: [:index]
  end
  resources :jobs, only: [:index], as: 'all_jobs'
  
  
  devise_scope :user do
    root to: 'devise/sessions#new'
    # get 'user_root_path', to: 'jobs#index'
  end
end