Rails.application.routes.draw do


  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  get '/feed', to: 'job_applications#all_apps', as: 'feed'
  scope :user do
    get '/feed', to: 'job_applications#index', as: 'user_feed'
    resources :job_applications, only: [:new]
    resources :jobs, except: [:index] do
      resources :job_applications, except: [:index, :new], as: 'applications'
    end
  end
  resources :jobs, only: [:index], as: 'all_jobs'
  
  
  devise_scope :user do
    root to: 'static_pages#home'
    # root to: 'devise/sessions#new'
    # get 'user_root_path', to: 'jobs#index'
  end
end